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

const pandaSdkIdlFilePath = `ohos_arm64/include/tools/es2panda/generated/es2panda_lib/es2panda_lib.idl`

export abstract class IVisitor {
    onEnterNamespace(node: core.IDLNamespace): void {}
    onEnterInterface(node: core.IDLInterface): void {}
    onEnterMethodDecl(node: core.IDLMethod): void {}
    //abstract onEnterPropertyDecl(node: core.IDLProperty): void
    onLeaveNamespace(node: core.IDLNamespace): void {}

    visit(node: IDLNode): void {
        switch (node.kind) {
            case core.IDLKind.File:
                (node as core.IDLFile).entries.forEach(n => this.visit(n))
                break;

            case core.IDLKind.Namespace: {
                const result = node as core.IDLNamespace
                this.onEnterNamespace(result);
                result.members.forEach(n => this.visit(n))
                this.onLeaveNamespace(result);
            } break;

            case core.IDLKind.Interface: {
                const result = node as core.IDLInterface

                this.onEnterInterface(result)
                this.registerInterface(result)

                result.constructors.forEach(n => this.visit(n))
                result.methods.forEach(n => this.visit(n))
            } break;

            case core.IDLKind.Method: {
                const result = node as core.IDLMethod
                this.onEnterMethodDecl(result);
            } break;
        }
    }

    private registerInterface(node: core.IDLInterface) : void {
        const prefix = 'es2panda_'
        const name = node.name.startsWith(prefix) ? node.name.slice(prefix.length) : node.name
        const prev = this.interfaceDeclarations.get(name)

        if (prev) {
            console.log(`Already has a ${name}(${node.name})`);
        } else {
            this.interfaceDeclarations.set(name, node)
        }
    }

    protected interfaceDeclarations = new Map<string, core.IDLInterface>()
}

class StdoutVisitor extends IVisitor {
    constructor() {
        super()
    }

    override onEnterNamespace(node: core.IDLNamespace): void {
        console.log(`namespace: ${node.name}`);
    }

    override onEnterInterface(node: core.IDLInterface): void {
        //console.log(`interface: ${node.name}`);
        const inher = node.inheritance.map(it => it.name).join('+')
        if (inher.length) console.log(inher);
    }

    override onEnterMethodDecl(node: core.IDLMethod): void {
        //console.log(`method: ${node.name}`);
    }
}

class PeerVisitor extends IVisitor {
    constructor(
        private config: Config,
        private idl: core.IDLFile
    ) {
        super()
    }

    override onEnterNamespace(node: core.IDLNamespace): void {
        console.log(`namespace: ${node.name}`);
    }

    override onEnterInterface(node: core.IDLInterface): void {
        const printer = new pp.PeerPrinter(this.config, this.idl, node)
        const out = printer.print()
        //console.log(out)
    }

    override onEnterMethodDecl(node: core.IDLMethod): void {
        //console.log(`method: ${node.name}`);
    }
}

class DelegateVisitor extends IVisitor {
    constructor(...delegates: IVisitor[]) {
        super()
        this.delegates = delegates;
    }

    onEnterNamespace(node: core.IDLNamespace): void {
        this.delegates.forEach(d => d.onEnterNamespace(node))
    }

    onEnterInterface(node: core.IDLInterface): void {
        this.delegates.forEach(d => d.onEnterInterface(node))
    }

    onEnterMethodDecl(node: core.IDLMethod): void {
        this.delegates.forEach(d => d.onEnterMethodDecl(node))
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
    const [idlFile, tokenMap] = toIDLFile(idlPath, { inheritanceMode: 'single' })

    const v = new DelegateVisitor(
        new StdoutVisitor(),
        new PeerVisitor(config, idlFile)
    )
    v.visit(idlFile)
}

main()
