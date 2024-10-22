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

import { IdlPeerLibrary } from "../../idl/IdlPeerLibrary"
import { IdlPeerMethod } from "../../idl/IdlPeerMethod"
import { ImportFeature } from "../../ImportsCollector"
import { LanguageWriter, createLanguageWriter, Type, NamedMethodSignature, Method, MethodModifier, MethodSignature, FieldModifier } from "../../LanguageWriters"
import { PeerLibrary } from "../../PeerLibrary"
import { PeerMethod } from "../../PeerMethod"
import { generateArkComponentName } from "../ComponentsPrinter"
import { componentToPeerClass } from "../PeersPrinter"
import { PrinterContext } from "../PrinterContext"
import { writeSerializer } from "../SerializerPrinter"
import { TargetFile } from "../TargetFile"
import { ARKOALA_PACKAGE, ARKOALA_PACKAGE_PATH, ARK_UI_NODE_TYPE, ARK_OBJECTBASE, INT_VALUE_GETTER } from "./Cangjie"
import { IdlSyntheticTypeBase } from "./CommonUtils"

export function makeCJSerializer(library: PeerLibrary | IdlPeerLibrary): { targetFile: TargetFile, writer: LanguageWriter } {
    let writer = createLanguageWriter(library.language)
    writer.print(`package idlize\n`)
    writeSerializer(library, writer)
    writer.print('public func createSerializer(): Serializer { return Serializer() }')
    return { targetFile: new TargetFile('Serializer', ARKOALA_PACKAGE_PATH), writer: writer }
}

export function makeCJNodeTypes(library: PeerLibrary | IdlPeerLibrary): { targetFile: TargetFile, writer: LanguageWriter } {
    if (library instanceof PeerLibrary) {
        // TODO remove after migrating to IDL
        throw new Error("We tried to generate old CJ node types ")
    }
    const componentNames = library.files.flatMap(file => {
        return Array.from(file.peers.values()).map(peer => peer.componentName)
    })
    const nodeTypesEnum = new CJEnum(undefined, ARK_UI_NODE_TYPE, componentNames.map((it, index) => { return { name: it, id: index } }))

    let writer = createLanguageWriter(library.language)
    writer.print(`package ${ARKOALA_PACKAGE};\n`)
    nodeTypesEnum.print(writer)

    return { targetFile: new TargetFile(ARK_UI_NODE_TYPE, ARKOALA_PACKAGE_PATH), writer: writer }
}

export class CJEnum extends IdlSyntheticTypeBase {
    public readonly isStringEnum: boolean
    public readonly members: {
        name: string,
        stringId: string | undefined,
        numberId: number,
    }[] = []
    constructor(source: Object | undefined, public name: string, members: { name: string, id: string | number | undefined }[]) {
        super(source)
        this.isStringEnum = members.every(it => typeof it.id == 'string')
        // TODO: string enums
        if (this.isStringEnum) {
            throw new Error(`String enum ${this.name} not supported yet in CJ`)
        }

        let memberValue = 0
        for (const member of members) {
            if (typeof member.id == 'string') {
                this.members.push({name: member.name, stringId: member.id, numberId: memberValue})
            }
            else if (typeof member.id == 'number') {
                memberValue = member.id
                this.members.push({name: member.name, stringId: undefined, numberId: memberValue})
            }
            else {
                this.members.push({name: member.name, stringId: undefined, numberId: memberValue})
            }
            memberValue += 1
        }
    }

    print(writer: LanguageWriter): void {
        writer.writeEnum(this.name, this.members, () => {
            writer.print("prop ordinal: Int32 {")
            writer.pushIndent()
            writer.print("get() {")
            writer.pushIndent()
            writer.print("match (this) {")
            writer.pushIndent()
            for (const member of this.members) {
                writer.print(`case ${member.name} => ${member.numberId}`)
            }
            writer.popIndent()
            writer.print("}")
            writer.popIndent()
            writer.print("}")
            writer.popIndent()
            writer.print("}")
        })
    }
}
