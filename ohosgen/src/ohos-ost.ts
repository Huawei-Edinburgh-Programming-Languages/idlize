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

import * as fs from 'fs'
import * as path from 'path'
import * as idl from "@idlizer/core/idl"
import { Language, PeerLibrary } from "@idlizer/core"
import {
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
    processNPrintArkTS,
    lowLevelLike,
    processNPrintCXX,
    roles,
    processNPrintTS,
    createProducer,
    mapName,
    TargetFile,
    readLangTemplate,
    getInteropRootPath,
    peerGeneratorConfiguration,
    readTemplate,
    libraryCcDeclaration
} from "@idlizer/libohos"

export function printOstFiles(peerLibrary: PeerLibrary): [Map<string, OutputFile>, Map<TargetFile, string>] {
    const declarations = generateOstDeclarations(peerLibrary)
    const SPECIAL_PACKAGES = [
        [MANAGED_PREFIX, 'engine'].join('.')
      ]
    const knownPackages = peerLibrary.files
        .map(file => file.packageClause.length ? file.packageClause : [peerLibrary.name.toLowerCase()])
        .map(clause => [MANAGED_PREFIX, ...clause].join('.'))
    return printOstDeclarations(declarations, peerLibrary, new Set(knownPackages.concat(SPECIAL_PACKAGES)))
}

function generateOstDeclarations(peerLibrary: PeerLibrary): LWDeclaration[] {
    const selector = new MakeSelector()

    selector.register(producers.native.serializerProducer)
    selector.register(producers.managed.serializerProducer)

    selector.register(producers.native.enumProducer)
    selector.register(producers.native.unionProducer)
    selector.register(producers.native.structureProducer)

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
    selector.register(createProducer(
        { is: idl.isConstant, role: roles.managed },
        (constant, ctx) => {
            return { artifact: { reference: T.cc("///managed.constant.fallback")}}
        }))

    const ctx = new GeneratorContext(peerLibrary.files, selector)
    return ctx.generate(peerLibrary.files)
}


function printOstDeclarations(decls: LWDeclaration[], peerLibrary: PeerLibrary, packages: Set<string>)
    : [Map<string, OutputFile>, Map<TargetFile, string>]
{
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

    const tsFiles = dumpTsLike(managed, peerLibrary.language, packages)
    const cFiles = dumpCLike([...cApi, ...native], peerLibrary.name)
    return [tsFiles, cFiles]
}

function dumpTsLike(decls: LWDeclaration[], language: Language, packages: Set<string>): Map<string, OutputFile> {
    decls = moduleLike.postprocess(decls)
    const files = moduleLike.formFiles(packages, decls)
    const result: Map<string, OutputFile> = new Map()
    const printer = language === Language.ARKTS ? processNPrintArkTS : processNPrintTS
    files.forEach((content, fileName) => {
        const mappedName = mapName(fileName)
        if (!mappedName)
            return
        const printed = content.body.map(it => printer(it, fileName, packages))
        result.set(mappedName, {
            imports: content.moduleLikeImports,
            content: printed,
            extension: ".ts",
            exported: true,
        })
    })
    return result
}

function dumpCLike(decls: LWDeclaration[], moduleName: string): Map<TargetFile, string> {
    const [capi, native] = lowLevelLike.postprocess(decls)

    ///copied from OhosNativeVisitor
    const interopRootPath = getInteropRootPath()
    const interopTypesPath = path.resolve(interopRootPath, 'src', 'cpp', 'interop-types.h')
    const interopTypesContent = fs.readFileSync(interopTypesPath, 'utf-8')
    const h = [
        readLangTemplate('ohos_api_prologue.h', Language.CPP),
        readTemplate('any_api.h'),
        readTemplate('generic_service_api.h'),
        processNPrintCXX(capi),
        readLangTemplate('ohos_api_epilogue.h', Language.CPP)
        ].join('\n')
        .replaceAll("%INTEROP_TYPES_HEADER", interopTypesContent)
        .replaceAll("%INCLUDE_GUARD_DEFINE%", `OH_${moduleName.toUpperCase()}_H`)
        .replaceAll("%LIBRARY_NAME%", moduleName.toUpperCase())
        .replaceAll("%API_KIND%", peerGeneratorConfiguration().ApiKind.toString())
    const cc = [
        readLangTemplate('api_impl_prologue.cc', Language.CPP),
        libraryCcDeclaration({removeCopyright: true}),
        readTemplate("api_getter.cc"),
        processNPrintCXX(native)
        ].join('\n')
        .replaceAll("%INTEROP_MODULE_NAME%", `${moduleName.toUpperCase()}NativeModule`)
        .replaceAll("%API_HEADER_PATH%", `${moduleName.toLowerCase()}.h`)
        .replaceAll("%API_KIND%", `OH_${moduleName}_APIKind::OH_${moduleName}_API_KIND`)
        .replaceAll("%API_NAME%", `OH_${moduleName}_API`)
        .replaceAll("%CALLBACK_KINDS%", 'typedef enum CallbackKind {\n} CallbackKind;') ///
        .replaceAll("%LIBRARY_NAME%", moduleName.toUpperCase())
    return new Map([
        [new TargetFile(`${moduleName.toLowerCase()}.h`), h],
        [new TargetFile(`${moduleName.toLowerCase()}.cc`), cc],
        [new TargetFile(`${moduleName.toLowerCase()}Impl_temp.cc`), ''],
        [new TargetFile(`${moduleName.toLowerCase()}ApiImpl_temp.cc`), ''],
    ])
}
