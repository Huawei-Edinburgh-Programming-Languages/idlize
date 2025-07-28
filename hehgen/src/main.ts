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

import { IDLFile, toIDLFile } from "@idlizer/core"
import { resolve } from "node:path"
import { GeneratorContext, MakeSelector } from "./context"
import { producers } from "./producers"
import { scan } from "./library/utils"
import { dumpTsLike, dumpCLike, dumpAsIs } from "./dump"
import { dumpToString, lw } from "lws"
import { isCApi, isManaged, isNative, MANAGED_PREFIX } from "./producers/common"

function generate(library: IDLFile[]) {
  const selector = new MakeSelector()

  selector.register(producers.native.serializerProducer)
  selector.register(producers.managed.serializerProducer)

  selector.register(producers.native.structureProducer)
  selector.register(producers.native.bridgeProducer)

  selector.register(producers.managed.fileProducer)
  selector.register(producers.managed.referenceProducer)
  selector.register(producers.managed.structureProducer)
  selector.register(producers.managed.primitiveProducer)
  selector.register(producers.managed.containerProducer)
  selector.register(producers.managed.nativeModuleProducer)

  const ctx = new GeneratorContext(library, selector)
  const produced = ctx.generate(library)

  processAndDump(produced, library)
}

function processAndDump(decls: lw.LWDeclaration[], library: IDLFile[]) {

  console.error(decls)
  const selectors = [
    isManaged,
    isCApi,
    isNative
  ]
  const buckets = selectors.map(predicate => [predicate, [] as lw.LWDeclaration[]] as const)

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

  const [
    managed,
    cApi,
    native
  ] = buckets.map(e => e[1])


  const SPECIAL_PACKAGES = [
    [MANAGED_PREFIX, 'engine'].join('.')
  ]
  const knownPackages = library.map(file => [MANAGED_PREFIX].concat(file.packageClause).join('.'))

  dumpTsLike(managed, new Set(knownPackages.concat(SPECIAL_PACKAGES)))
  dumpCLike(cApi)
  dumpAsIs(native)
}

function main() {
  const fileNames = scan(resolve(__dirname, '..', '..', 'idl', 'test'))
  const library = fileNames.map(fileName => toIDLFile(fileName)[0])

  generate(library)
}
main()
