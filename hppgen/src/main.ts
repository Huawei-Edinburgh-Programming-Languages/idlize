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

import * as idl from "@idlizer/core/idl"
import { execSync } from "node:child_process"
import { parseAstDump } from "./parser"
import { InterfaceNode, NodeKind, toAST } from "./toAST"
import { toIDLInterface } from "./toIDL"

function main() {
    const buffer = execSync(`clang++ -Xclang -ast-dump -fsyntax-only "${process.argv[2]}"`)
    const astText = new TextDecoder('utf-8').decode(buffer)
    const parsed = parseAstDump(astText)

    const userDecls = parsed.children.filter(x => !x.content.find(t => t === '<<invalid sloc>>'))
    const ast = userDecls.flatMap(toAST)

    const file = idl.createFile(
        ast
            .filter(x => x.kind === NodeKind.Interface)
            .map(x => x as InterfaceNode)
            .filter(x => x.isDefinition)
            .map(toIDLInterface)
    )
    console.log(idl.toIDLString(file, {}))
}
main()
