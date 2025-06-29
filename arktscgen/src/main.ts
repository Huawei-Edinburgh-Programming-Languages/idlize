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

import * as path from "node:path"
import { IDLNode, toIDLFile } from "@idlizer/core"
import * as core from "@idlizer/core"
import { DynamicEmitter } from "./emitters/DynamicEmitter"
import { Config } from "./general/Config"
import { IgnoreOptions, IrHackOptions } from "./options/IgnoreOptions"
import { StaticEmitter } from "./emitters/StaticEmitter"
import { cliOptions } from "./options/cli-options"
import { NonNullableOptions } from "./options/NonNullableOptions"
import { CodeFragmentOptions } from "./options/CodeFragmentOptions"
import { isReal } from "./general/common"
import * as pp from "./printers/library/PeerPrinter";
import { IVisitor } from './Visitor'
import { PeerVisitor } from './PeerVisitor'

const pandaSdkIdlFilePath = `ohos_arm64/include/tools/es2panda/generated/es2panda_lib/es2panda_lib.idl`

class StdoutVisitor extends IVisitor {
    constructor() {
        super()
    }

    override onEnterNamespace(node: core.IDLNamespace): boolean {
        console.log(`namespace: ${node.name}`);
        return true
    }

    override onEnterInterface(node: core.IDLInterface): boolean {
        //console.log(`interface: ${node.name}`);
        const inher = node.inheritance.map(it => it.name).join('+')
        if (inher.length) console.log(inher);
        return true
    }

    override onEnterMethodDecl(node: core.IDLMethod): boolean {
        //console.log(`method: ${node.name}`);
        return true
    }
}

class DelegateVisitor extends IVisitor {
    constructor(...delegates: IVisitor[]) {
        super()
        this.delegates = delegates;
    }

    onEnterNamespace(node: core.IDLNamespace): boolean {
        this.delegates.forEach(d => d.onEnterNamespace(node))
        return true
    }

    onEnterInterface(node: core.IDLInterface): boolean {
        this.delegates.forEach(d => d.onEnterInterface(node))
        return true
    }

    onEnterMethodDecl(node: core.IDLMethod): boolean {
        this.delegates.forEach(d => d.onEnterMethodDecl(node))
        return true
    }

    private delegates: IVisitor[] = []
}

function main() {
    const options = cliOptions()
    if (options.initialize) {
        new StaticEmitter(
            options.outputDir,
            options.pandaSdkPath
        ).emit()
    }

    const config = new Config(
        new IgnoreOptions(options.optionsFile),
        new NonNullableOptions(options.optionsFile),
        new IrHackOptions(options.optionsFile),
        new CodeFragmentOptions(options.optionsFile),
    )
    const idlPath = path.join(options.pandaSdkPath, pandaSdkIdlFilePath)
    const [idlFile, tokenMap] = toIDLFile('poor.idl', { inheritanceMode: 'single' })

    const v = new DelegateVisitor(
        new StdoutVisitor(),
        new PeerVisitor(config, idlFile)
    )
    v.visit(idlFile)
}

main()
