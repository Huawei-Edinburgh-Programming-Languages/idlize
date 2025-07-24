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
import { dumpTsLike, dumpCLike } from "./dump"
import { dumpToString, lw } from "lws"
import { dropBucketName, isCApi, isManaged, isNative } from "./producers/common"

function generate(library: IDLFile[]) {
  const selector = new MakeSelector()

  selector.register(producers.native.structureProducer)

  selector.register(producers.managed.fileProducer)
  selector.register(producers.managed.referenceProducer)
  selector.register(producers.managed.structureProducer)
  selector.register(producers.managed.primitiveProducer)
  selector.register(producers.managed.containerProducer)
  selector.register(producers.managed.nativeModuleProducer)
  selector.register(producers.managed.serializerProducer)

  const ctx = new GeneratorContext(library, selector)
  const produced = ctx.generate(library)

  dumpTsLike(produced, library)
}

function processAndDump(decls:lw.LWDeclaration[]) {

  const buckets: [(decl)] = 

  decls.forEach(decl => {
    if (isManaged(decl.name)) {
      buckets.managed.push(dropBucketName(decl))
    }
    if (isCApi(decl.name)) {
      buckets.cApi.push(dropBucketName(decl))
    }
    if (isNative(decl.name)) {
      buckets.native.push(dropBucketName(decl))
    }
    console.error(dumpToString(decl))
    throw new Error("Can not process generated code!")
  })
}

function main() {
  const fileNames = scan(resolve(__dirname, '..', '..', 'idl', 'test'))
  const library = fileNames.map(fileName => toIDLFile(fileName)[0])

  generate(library)
}
main()
