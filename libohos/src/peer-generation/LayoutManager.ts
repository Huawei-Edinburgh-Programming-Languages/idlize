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
import { join } from "node:path"
import * as idl from "@idlizer/core"
import { writeIntegratedFile } from "./common"
import { getNamespaceName, getNamespacesPathFor, Language, LanguageWriter, LayoutManager, LayoutTargetDescription, PeerLibrary, wrapCurrentFileDescription } from "@idlizer/core"
import { ImportsCollector } from "./ImportsCollector"
import { tsCopyrightAndWarning } from "./FileGenerators"
import { peerGeneratorConfiguration } from "../DefaultConfiguration"
import { collectDeclItself } from "./ImportsCollectorUtils"

export interface PrinterResult {
    over: LayoutTargetDescription
    generate: () => LanguageWriter | {
        imports: ImportsCollector
        content: LanguageWriter
    }
    private?: boolean
    weight?: number
    ignoreNamespace?: boolean
}

interface ExecutedPrinterResult {
    over: LayoutTargetDescription
    content: LanguageWriter
    imports: ImportsCollector
    private?: boolean
    weight?: number
    ignoreNamespace?: boolean

}

export type OutputFile = { content: string[], imports: ImportsCollector, extension: string, exported: boolean }

export interface PrinterClass {
    print(library: PeerLibrary): PrinterResult[]
}
export interface PrinterFunction {
    (library: PeerLibrary): PrinterResult[]
}
export type Printer = PrinterClass | PrinterFunction

function isEntryExported(entry: idl.IDLEntry): boolean {
    if (!peerGeneratorConfiguration().currentModuleExportedPackages)
        return true
    const entryPackage = idl.getPackageClause(entry)
    return peerGeneratorConfiguration().currentModuleExportedPackages!.some(it => {
        const packageClause = it.split('.')
        return packageClause.every((part, index) => part === entryPackage.at(index))
    })
}

export function install(
    outDir: string,
    library: PeerLibrary,
    printers: Printer[],
    options?: {
        fileExtension?: string,
        customLayout?: LayoutManager,
        isDeclared?: boolean,
}): string[] {
    return installFiles(outDir, library, printFiles(library, printers, options))
}

export function printFiles(library: PeerLibrary, printers: Printer[], options?: {
    fileExtension?: string,
    customLayout?: LayoutManager,
    isDeclared?: boolean,
}): Map<string, OutputFile> {
    const storage = new Map<string, ExecutedPrinterResult[]>()

    // groupBy
    const layout = options?.customLayout ?? library.layout
    printers.flatMap(it => typeof it === 'function' ? it(library) : it.print(library)).forEach(it => {
        const resolved = layout.resolve(it.over)
        if (resolved == '') {
            throw new Error(`Cannot resolve location for ${idl.getFQName(it.over.node)}`)
        }
        const filePath = path.normalize(resolved)
        if (!storage.has(filePath)) {
            storage.set(filePath, [])
        }
        const executionResult = wrapCurrentFileDescription(it.over, it.generate)
        storage.get(filePath)?.push({
            over: it.over,
            ignoreNamespace: it.ignoreNamespace,
            private: it.private,
            weight: it.weight,
            content: executionResult instanceof LanguageWriter ? executionResult : executionResult.content,
            imports: executionResult instanceof LanguageWriter ? new ImportsCollector : executionResult.imports,
        })
    })

    // print
    const result: Map<string, OutputFile> = new Map()
    Array.from(storage.entries()).forEach(([filePath, results]) => {
        results.sort((a, b) => (a.weight ?? 0) - (b.weight ?? 0))
        results.sort(sortByNamespaces)

        const imports = new ImportsCollector()
        results.forEach(it => {
            wrapCurrentFileDescription(it.over, () => {
                it.content.features.forEach(feature => {
                    if (feature.type === "raw")
                        imports.addFeature(feature)
                    else
                        collectDeclItself(library, feature.node, imports)
                })
                imports.merge(it.imports)
            })
        })
        result.set(filePath, {
            content: printWithNamespaces(library, results, { isDeclared: !!options?.isDeclared }),
            imports,
            extension: options?.fileExtension ?? library.language.extension,
            exported: !results.every(it => !!it.private || !isEntryExported(it.over.node))
        })
    })
    return result
}

export function installFiles(outDir: string, library: PeerLibrary, files: Map<string, OutputFile>): string[] {
    const installedToExport: string[] = []
    files.forEach(({ content, imports, extension, exported }, filePath) => {
        const codePrefix: string[] = []
        if (library.language === Language.KOTLIN) {
            codePrefix.push(`package ${filePath}\n`)
        }
        if (library.language === Language.CJ) {
            imports.clear()

            const hasCustomPackage = content.some(line => line.trim().startsWith('package '))

            if (!hasCustomPackage) {
                const folder = path.dirname(filePath)
                let pkg = 'idlize'
                
                if (folder !== '.' && folder !== path.join('arkoala-cj', 'cjv2', 'src')) {
                    pkg = 'idlize.' + folder.replace(/\//g, '.')
                }
                codePrefix.push(`package ${pkg}`, '')
            }

            codePrefix.push('')
            codePrefix.push('import std.collection.*')
            codePrefix.push('import Interop.*')
            codePrefix.push('import KoalaRuntime.*')
            codePrefix.push('import KoalaRuntime.memoize.*')
            codePrefix.push('import std.time.DateTime')
            codePrefix.push('')

            const folder = path.dirname(filePath)
            if (folder.endsWith('components')) {
                codePrefix.push('import idlize.peers.*', '')
                codePrefix.push('import idlize.interfaces.*', '')
                codePrefix.push('import idlize.interfaces.Resource as IResource', '')
            } else if (folder.endsWith('peers')) {
                codePrefix.push('import idlize.interfaces.*', '')
                codePrefix.push('import idlize.interfaces.Resource as IResource', '')
            }

            // for Main.cj file
            const fileName = path.basename(filePath, '.cj')
            if (fileName === 'Main') {
                const demoInstallPath = path.join(path.dirname(filePath), 'demo', 'Main.cj')
                const text = tsCopyrightAndWarning(
                    codePrefix.concat(content).join('\n')
                )
                writeIntegratedFile(demoInstallPath, text, 'producing')
            }
        }

        const importsWriter = library.createLanguageWriter()
        imports.print(importsWriter, filePath, outDir)
        let body = content.join('\n')
        // In non-interfaces (peers/components) files, rewrite unqualified Resource to IResource to avoid ambiguity
        if (library.language === Language.CJ) {
            const folder = path.dirname(filePath)
            if (folder.endsWith('components') || folder.endsWith('peers')) {
                // replace standalone Resource tokens (not part of a larger identifier or qualified name)
                body = body.replace(/(?<![\w\.])Resource\b/g, 'IResource')
            }
        }
        const completeCode = codePrefix.concat(importsWriter.getOutput()).join('\n') + '\n' + body
        const text = tsCopyrightAndWarning(completeCode)

        const installPath = join(outDir, filePath) + extension
        if (exported) {
            installedToExport.push(installPath)
        }
        writeIntegratedFile(installPath, text, 'producing')
    })

    return installedToExport
}

function printWithNamespaces(library: PeerLibrary, results: ExecutedPrinterResult[], options: { isDeclared: boolean }): string[] {
    const resultsContent = library.createLanguageWriter()
    const resultsContentCache: string[] = []
    for (const record of results) {
        wrapNamespaces(record, resultsContentCache, resultsContent, options)
        resultsContent.concat(record.content)
    }
    wrapNamespaces(undefined, resultsContentCache, resultsContent, options)
    return resultsContent.getOutput()
}

function wrapNamespaces(item: ExecutedPrinterResult | undefined, alreadyWrapped: string[], writer: LanguageWriter, options: { isDeclared: boolean }): void {
    const node = item?.over.node
    const ns = node ? getNamespacePathFromResult(item) : []
    let bestMatch = 0
    while (bestMatch < ns.length && bestMatch < alreadyWrapped.length) {
        if (ns[bestMatch].name != alreadyWrapped[bestMatch])
            break
        bestMatch++
    }
    for (let i = bestMatch, end = alreadyWrapped.length; i < end; i++) {
        writer.popNamespace({ ident: true })
        alreadyWrapped.pop()
    }
    for (let i = bestMatch; i < ns.length; i++) {
        const defaultNamespace = idl.hasExtAttribute(ns[i], idl.IDLExtendedAttributes.DefaultExport)
        writer.pushNamespace(ns[i].name, { ident: true, isDefault: defaultNamespace, isDeclared: options.isDeclared })
        alreadyWrapped.push(ns[i].name)
    }
}

function sortByNamespaces(a: ExecutedPrinterResult, b: ExecutedPrinterResult): number {
    return getNamespaceNameFromResult(a).localeCompare(getNamespaceNameFromResult(b))
}

function getNamespaceNameFromResult(a:ExecutedPrinterResult): string {
    return a.ignoreNamespace ? '' : getNamespaceName(a.over.node)
}

function getNamespacePathFromResult(a:ExecutedPrinterResult): idl.IDLNamespace[] {
    return a.ignoreNamespace ? [] : getNamespacesPathFor(a.over.node)
}
