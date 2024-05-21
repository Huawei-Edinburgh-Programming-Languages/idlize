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

import { IndentedPrinter } from "../IndentedPrinter";
import { accessorStructList } from "./FileGenerators";
import { MaterializedClass, MaterializedMethod } from "./Materialized";
import { ModifierLikeVisitor } from "./ModifierPrinter";
import { PeerFile } from "./PeerFile";
import { DeclarationTable } from "./DeclarationTable";

export class AccessorVisitor extends ModifierLikeVisitor {
    override listTemplate = accessorStructList

    constructor(declarationTable: DeclarationTable) {
        super(declarationTable)
    }

    private printRealAndDummyAccessor(clazz: MaterializedClass) {
        this.modifierLikeList.pushIndent()
        this.printMaterializedClassProlog(clazz);
        [clazz.ctor, clazz.dtor].concat(clazz.methods).forEach(method => {
            this.printMaterializedMethod(this.dummy, method, it => this.printDummyImplFunctionBody(it))
            this.printMaterializedMethod(this.real, method, it => this.printModifierImplFunctionBody(it))
            this.modifierLikes.print(`${method.originalParentName}_${method.method.name},`)
        })
        this.printMaterializedClassEpilog(clazz)
        this.modifierLikeList.popIndent()
    }

    private printMaterializedClassProlog(clazz: MaterializedClass) {
        const accessor = `${clazz.className}Accessor`
        this.modifierLikes.print(`ArkUI${accessor} ${accessor}Impl {`)
        this.modifierLikes.pushIndent()
        this.modifierLikeList.print(`Get${accessor},`)
    }

    private printMaterializedClassEpilog(clazz: MaterializedClass) {
        this.modifierLikes.popIndent()
        this.modifierLikes.print(`};\n`)
        const accessor = `${clazz.className}Accessor`
        this.modifierLikes.print(`const ArkUI${accessor}* Get${accessor}() { return &${accessor}Impl; }\n\n`)
    }

    private printMaterializedMethod(printer: IndentedPrinter, method: MaterializedMethod, printBody: (m: MaterializedMethod) => void) {
        this.printMethodProlog(printer, method)
        printBody(method)
        this.printMethodEpilog(printer)
    }

    override printRealAndDummyModifierLikes(peerFile: PeerFile) {
        peerFile.materializedClasses.forEach((materializedClass, _) => {
            this.printRealAndDummyAccessor(materializedClass)
        })
        return {
            dummy: this.dummy.getOutput(),
            real: this.real.getOutput()
        }
    }
}
