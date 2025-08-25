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

import { D, lw } from "../../ost/main";

export function mergeStructs(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    const index = new Map<string, (lw.ClassDeclaration | lw.StructureDeclaration)[]>()
    const others: lw.LWDeclaration[] = []
    decls.forEach(decl => {
        if (decl.kind !== lw.LWKind.ClassDeclaration && decl.kind !== lw.LWKind.StructureDeclaration) {
            others.push(decl)
            return
        }
        if (decl.generics.length > 0) {
            return
        }
        if (!index.has(decl.name)) {
            index.set(decl.name, [])
        }
        index.get(decl.name)?.push(decl)
    })

    const result: lw.LWDeclaration[] = others
    index.forEach((records, name) => {
        if (records.length === 0) {
            return
        }
        if (records.length === 1) {
            result.push(records[0])
            return
        }
        const tmp = D.class(name, [], [])
        records.forEach(rec => {
            if (rec.kind === lw.LWKind.ClassDeclaration) {
                tmp.fields.push(...rec.fields)
                tmp.methods.push(...rec.methods)
            } else {
                tmp.fields.push(...rec.members)
            }
        })
        result.push(tmp)
    })
    return result
}
