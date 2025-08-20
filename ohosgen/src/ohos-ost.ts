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

import * as idl from "@idlizer/core/idl"
import { generatorConfiguration, Language, PeerLibrary } from "@idlizer/core"
import {
    createSpecialProducer,
    LWDeclaration,
    MakeSelector,
    MANAGED_PREFIX,
    OutputFile,
    producers,
    T,
    GeneratorContext,
    isManaged,
    isCApi,
    isNative,
    dumpToString,
    moduleLike,
    ImportsCollector,
    processNPrintArkTS,
    lowLevelLike,
    processNPrintCXX,
    roles,
    processNPrintTS,
    createProducer
} from "@idlizer/libohos"

export function printOstFiles(peerLibrary: PeerLibrary): Map<string, OutputFile> {
    const declarations = generateOstDeclarations(peerLibrary)
    const SPECIAL_PACKAGES = [
        [MANAGED_PREFIX, 'engine'].join('.')
      ]
    const knownPackages = peerLibrary.files
        .map(file => file.packageClause.length ? file.packageClause : [peerLibrary.name.toLowerCase()])
        .map(clause => [MANAGED_PREFIX, ...clause].join('.'))
    return printOstDeclarations(declarations, peerLibrary.language, new Set(knownPackages.concat(SPECIAL_PACKAGES)))
}

function generateOstDeclarations(peerLibrary: PeerLibrary): LWDeclaration[] {
    const selector = new MakeSelector()

    selector.register(producers.native.serializerProducer)
    selector.register(producers.managed.serializerProducer)

    selector.register(producers.native.enumProducer)
    selector.register(producers.native.unionProducer)
    selector.register(producers.native.structureProducer)
    selector.register(producers.native.bridgeProducer)

    selector.register(producers.managed.fileProducer)
    selector.register(producers.managed.referenceProducer)
    selector.register(producers.managed.structureProducer)
    selector.register(producers.managed.primitiveProducer)
    selector.register(producers.managed.functionProducer)
    selector.register(producers.managed.enumProducer)
    selector.register(producers.managed.unionProducer)
    selector.register(producers.managed.callbackProducer)
    selector.register(producers.managed.containerProducer)
    selector.register(producers.managed.typedefProducer)
    selector.register(producers.managed.nativeModuleProducer)

    /// fallback producers
    selector.register(createSpecialProducer(
        { is: idl.isConstant, role: roles.managed },
        (constant, ctx) => {
            return { artifact: { reference: T.cc("///managed.constant.fallback")}}
        }))

    const ctx = new GeneratorContext(peerLibrary.files, selector)
    return ctx.generate(peerLibrary.files)
}


function printOstDeclarations(decls: LWDeclaration[], language: Language, packages: Set<string>): Map<string, OutputFile> {
    const selectors = [ isManaged, isCApi, isNative ]
    const buckets = selectors.map(predicate => [predicate, [] as LWDeclaration[]] as const)

    decls.forEach(decl => {
        for (const [predicate, bucket] of buckets) {
            if (predicate(decl.name)) {
                bucket.push(decl)
                return
            }
        }
        console.error(dumpToString(decl))
        throw new Error("Can not process generated code!")
    })
    const [ managed, cApi, native ] = buckets.map(e => e[1])

    const tsFiles = dumpTsLike(managed, language, packages)
    const cFiles = dumpCLike(cApi)
    const nativeFiles = dumpAsIs(native)
    return tsFiles /// ...cFiles, ...nativeFiles])
}

function mapOstFileName(name: string): string {
    return name
        .replace(/^managed\./, '')
        .replace(/^native\./, '')
        .replace(/^engine/, generatorConfiguration().moduleName + ".INTERNAL")
}

function dumpTsLike(decls: LWDeclaration[], language: Language, packages: Set<string>): Map<string, OutputFile> {
    decls = moduleLike.postprocess(decls)
    const files = moduleLike.formFiles(packages, decls)
    const result: Map<string, OutputFile> = new Map()
    const printer = language === Language.ARKTS ? processNPrintArkTS : processNPrintTS
    files.forEach((content, fileName) => {
        const mappedName = mapOstFileName(fileName)
        if (!mappedName)
            return
        const printed = content.body.map(it => printer(it, fileName, packages))
        result.set(mappedName, {
            imports: content.moduleLikeImports,
            content: printed,
            extension: language === Language.ARKTS ? ".ets" : ".ts",
            exported: false,
        })
    })
    return result
}

function dumpCLike(decls: LWDeclaration[]) {
    decls = lowLevelLike.postprocess(decls)
    // filter out random crap
    const modulePrefix = `capi.${generatorConfiguration().moduleName}`
    const synthPrefix = 'synthetic.'
    decls = decls.filter(it => it.name.startsWith(modulePrefix) || it.name.startsWith(synthPrefix))
    console.log("===================== C-API =====================")
    decls.forEach(decl => {
        console.log(processNPrintCXX(decl))
    })
}

function dumpAsIs(decls: LWDeclaration[]) {
    console.log("==================== NATIVE ====================")
    decls.forEach(decl => {
        console.log(processNPrintCXX(decl))
    })
}
