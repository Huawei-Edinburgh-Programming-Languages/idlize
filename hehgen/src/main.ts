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

import { toIDLFile } from "@idlizer/core"
import { resolve } from "node:path"
import { GeneratorContext, MakeSelector } from "./context"
import { Producers } from "./producers"
import { scan } from "./library/utils"
import { formFiles, postprocess } from "./postprocess"
import { processNPrintTS } from "lws"
import { EOL } from "node:os"

function main() {
  const fileNames = scan(resolve(__dirname, '..', '..', 'idl', 'test'))
  const library = fileNames.map(fileName => toIDLFile(fileName)[0])

  const selector = new MakeSelector()
  selector.register(Producers.fileProducer)
  selector.register(Producers.referenceProducer)
  selector.register(Producers.structureProducer)
  selector.register(Producers.primitiveProducer)
  selector.register(Producers.containerProducer)
  selector.register(Producers.nativeModuleProducer)
  selector.register(Producers.serializerProducer)

  const ctx = new GeneratorContext(library, selector)
  const decls = postprocess(ctx.generate(library))
  const files = formFiles(new Set(library.map(file => file.packageClause.join('.'))), decls)
  files.forEach((content, name) => {
    console.log('-------------------------------------------------')
    console.log('FILE: ', name)
    console.log('')
    console.log(content.map(processNPrintTS).join(EOL))
    console.log('-------------------------------------------------')
  })
}
main()
