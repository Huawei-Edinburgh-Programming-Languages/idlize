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

import { IDLInterface, IDLReferenceType } from "../idl"
import { Field, Method } from "../LanguageWriters/LanguageWriter"
import { isDefined } from "../util"

export class BuilderClass {
    constructor(
        public readonly declaration: IDLInterface,
        public readonly name: string,
        public readonly generics: string[] | undefined,
        public readonly isInterface: boolean,
        public readonly superClass: IDLReferenceType | undefined,
        public readonly fields: Field[],
        public readonly constructors: Method[],
        public readonly methods: Method[],
        public readonly needBeGenerated: boolean = true,
    ) { }
}

export const CUSTOM_BUILDER_CLASSES: BuilderClass[] = []

export function isCustomBuilderClass(name: string): boolean {
    return isDefined(CUSTOM_BUILDER_CLASSES.find(it => it.name === name))
}

export function methodsGroupOverloads(methods: Method[]): Method[][] {
    const seenNames = new Set<string>()
    const groups: Method[][] = []
    for (const method of methods) {
        if (seenNames.has(method.name))
            continue
        seenNames.add(method.name)
        groups.push(methods.filter(it => it.name === method.name))
    }
    return groups
}
