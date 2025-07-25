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

import { LWDeclaration } from "lws/dist/lws";
import * as moduleLike from "./postprocess/moduleLike";
import * as lowLevelLike from "./postprocess/lowLevelLike";
import { IDLFile } from "@idlizer/core/idl";
import { processNPrintCXX, processNPrintTS } from "lws";
import { EOL } from "os";

export function dumpTsLike(decls: LWDeclaration[], packages:Set<string>) {
    decls = moduleLike.postprocess(decls)
    const files = moduleLike.formFiles(packages, decls)
    files.forEach((content, name) => {
        console.log('-------------------------------------------------')
        console.log('FILE: ', name)
        console.log('')
        let text = ''
        content.moduleLikeImports.forEach((vals, source) => {
            text += `import {${Array.from(vals).join(', ')}} from "./${source}"${EOL}`
        })
        if (content.moduleLikeImports.size > 0) {
            text += EOL
        }
        text += content.body.map(processNPrintTS).join(EOL)
        console.log(text)
        console.log('-------------------------------------------------')
    })
}

export function dumpCLike(decls: LWDeclaration[]) {
    decls = lowLevelLike.postprocess(decls)
    console.log("===================== C-API =====================")
    decls.forEach(decl => {
        console.log(processNPrintCXX(decl))
    })
}

export function dumpAsIs(decls: LWDeclaration[]) {
    console.log("==================== NATIVE ====================")
    decls.forEach(decl => {
        console.log(processNPrintCXX(decl))
    })
}
