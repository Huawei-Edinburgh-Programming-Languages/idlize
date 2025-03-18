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

import { createFile, createProperty, IDLFile, IDLInterface, IDLMethod, isDefined, isInterface } from "@idlizer/core"
import { Transformer } from "../../Transformer"
import { Config } from "../../../Config"
import { withoutPostfix, withoutPrefix, withPrefix } from "../../../utils/string"
import { isGetter } from "../../../general/common";
import { createUpdatedInterface } from "../../../utils/idl"
import { Context } from "../../../general/Context";

type Match = { getter: IDLMethod, setter: IDLMethod }

export class AugmentPropertyTransformer implements Transformer {
    constructor(
        private context: Context
    ) {}

    transformed(): IDLFile {
        return createFile(
            this.context.file.entries
                .map(it => {
                    if (isInterface(it)) {
                        return this.transformInterface(it)
                    }
                    return it
                })
        )
    }

    private transformInterface(node: IDLInterface): IDLInterface {
        const creates = node.methods.filter(it => Config.isCreate(it.name))
        if (creates.length !== 1) {
            return node
        }
        return this.withAugmentedProperties(node)
    }

    private withAugmentedProperties(node: IDLInterface): IDLInterface {
        const pairs = this.pairsToMerge(node)
        const merged = pairs.flatMap(it => [it.getter, it.setter])

        this.context.augmentedProperties.set(
            node,
            pairs.map(it => createProperty(propertyName(it.getter), it.getter.returnType))
        )
        return createUpdatedInterface(
            node,
            node.methods
                .filter(it => !merged.includes(it))
        )
    }

    private pairsToMerge(node: IDLInterface): Match[] {
        return node.methods
            .filter(isGetter)
            .map(getter => {
                const setter = node.methods
                    .find(it => it.name === setterName(getter))
                if (setter === undefined) {
                    return undefined
                }
                return { getter, setter }
            })
            .filter(isDefined)
    }
}

function setterName(getter: IDLMethod): string {
    return withPrefix(
        Config.setterPrefix,
        propertyName(getter)
    )
}

function propertyName(getter: IDLMethod): string {
    return withoutPrefix(
        Config.getterPrefix,
        withoutPostfix(
            Config.constPostfix,
            withoutPrefix(
                Config.isPrefix,
                getter.name
            )
        )
    )
}