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

import { getOrPut } from "../util"
import { PeerClass } from "./PeerClass"
import { DeclarationTable } from "./DeclarationTable"
import { MaterializedClass } from "./Materialized";
import * as path from "path"

export class EnumEntity {
    constructor(
        public readonly name: string,
        public readonly comment: string,
        public readonly members: EnumMember[] = [],
    ) {}
    pushMember(name: string, comment: string, initializerText: string | undefined) {
        this.members.push(new EnumMember(name, comment, initializerText))
    }
}

class EnumMember {
    constructor(
        public readonly name: string,
        public readonly comment: string,
        public readonly initializerText: string | undefined,
    ) {}
}

export class PeerFile {
    readonly peers = new Map<string, PeerClass>()
    readonly materializedClasses = new Map<string, MaterializedClass>()
    readonly enums: EnumEntity[] = []

    public readonly modifiersFileName: string

    constructor(
        public readonly originalFilename: string,
        public readonly declarationTable: DeclarationTable,
    ) {
        this.modifiersFileName = path.basename(originalFilename, ".d.ts") + ".cc"
    }

    getOrPutPeer(componentName: string) {
        return getOrPut(this.peers, componentName, () => new PeerClass(this, componentName, this.originalFilename, this.declarationTable))
    }

    pushEnum(enumEntity: EnumEntity) {
        this.enums.push(enumEntity)
    }
}