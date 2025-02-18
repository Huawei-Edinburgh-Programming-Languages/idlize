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

import { IDLEntry } from "../idl";

export enum LayoutNodeRole {
    PEER,
    INTERFACE,
    GLOBAL,
}

export interface LayoutManagerStrategy {
    resolve(node:IDLEntry, role:LayoutNodeRole): string | [importPath:string, filePath:string]
}

export class LayoutManager {
    constructor(
        private strategy: LayoutManagerStrategy
    ) { }

    resolve(node:IDLEntry, role:LayoutNodeRole): string {
        return this.resolveImport(node, role)
    }

    resolveFile(node:IDLEntry, role:LayoutNodeRole): string {
        const result = this.strategy.resolve(node, role)
        if (Array.isArray(result)) {
            return result[1]
        }
        return result
    }

    resolveImport(node:IDLEntry, role:LayoutNodeRole): string {
        const result = this.strategy.resolve(node, role)
        if (Array.isArray(result)) {
            return result[0]
        }
        return result
    }

    ////////////////////////////////////////////////////////////////////

    static Empty(): LayoutManager {
        return new LayoutManager({ resolve: () => '' })
    }
}
