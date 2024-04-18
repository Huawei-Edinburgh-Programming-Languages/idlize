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
import * as ts from "typescript"
import { asString, stringOrNone } from "../util";
import { DeclarationTable, DeclarationTarget } from "./DeclarationTable";

export class SortingEmitter extends IndentedPrinter {
    currentPrinter?: IndentedPrinter
    emitters = new Map<DeclarationTarget, IndentedPrinter>()

    constructor(private table: DeclarationTable) {
        super()
    }

    private undecorate(name: string): string {
        return name.replace(/^(Optional_)*(.*?)(\*)*$/, '$2')
    }

    private fillDepsInDepth(target: DeclarationTarget, seen: Set<DeclarationTarget>) {
        if (seen.has(target)) return
        seen.add(target)
        // Need to request that declaration.
        this.table.addDeclaration(target)
        let struct = this.table.targetStruct(target)
        struct.supers.forEach(it => this.fillDepsInDepth(it, seen))
        struct.getFields().forEach(it => this.fillDepsInDepth(it.declaration, seen))
    }

    private getDeps(target: DeclarationTarget): DeclarationTarget[] {
        let result: DeclarationTarget[] = []
        let struct = this.table.targetStruct(target)
        struct.supers.forEach(it => result.push(it))
        struct.getFields().forEach(it => {
            result.push(it.declaration)
        })
        return result
    }

    startEmit(table: DeclarationTable, declaration: DeclarationTarget) {
        this.table = table
        let next = this.emitters.has(declaration) ? this.emitters.get(declaration)! : new IndentedPrinter()
        this.emitters.set(declaration, next)
        this.currentPrinter = next
        let seen = new Set<DeclarationTarget>()
        this.fillDepsInDepth(declaration, seen)
        table.processPendingRequests()
        // if (seen.size > 0) console.log(`${name}: depends on ${Array.from(seen.keys()).join(",")}`)
    }
    printType(type: ts.TypeNode): string {
        return ts.isTypeReferenceNode(type)
            ? asString(type.typeName)
            : `${type.kind}:${ts.SyntaxKind[type.kind]}`
    }

    print(value: stringOrNone) {
        if (!this.currentPrinter) throw new Error("startEmit() first")
        if (value) this.currentPrinter.print(value)
    }

    pushIndent(): void {
        this.currentPrinter?.pushIndent()
    }

    popIndent(): void {
        this.currentPrinter?.popIndent()
    }

    getOutput(): string[] {
        let result: string[] = []
        let sortedTypes = this.getToposorted()
        sortedTypes.forEach(type => {
            let next = this.emitters.get(type)?.getOutput()
            if (next) result = result.concat(next)
        })
        return result
    }

    // Kahn's algorithm.
    getToposorted(): DeclarationTarget[] {
        let result: DeclarationTarget[] = []
        let input = Array.from(this.emitters.keys())
        let adjMap = new Map<DeclarationTarget, DeclarationTarget[]>()
        for (let key of input) {
            adjMap.set(key, this.getDeps(key))
        }
        let count = 0
        // Build adj map.
        let inDegree = new Map<DeclarationTarget, number>()
        for (let k of input) {
            let array: DeclarationTarget[] = []
            inDegree.set(k, 0)
            adjMap.get(k)?.forEach(it => {
                array.push(it)
            })
            count++
        }
        // Compute in-degrees.
        for (let k of input) {
            for (let it of adjMap.get(k)!) {
                let old = inDegree.get(it)
                if (old == undefined) {
                    // throw new Error(`Forgotten type: ${it} of ${k}`)
                    old = 0
                }
                inDegree.set(it, old + 1)
            }
        }
        let queue: DeclarationTarget[] = []
        // Insert elements with in-degree 0
        for (let k of input) {
            if (inDegree.get(k)! == 0) {
                queue.push(k)
            }
        }
        // Add all elements with 0
        while (queue.length > 0) {
            let e = queue.shift()!
            result.unshift(e)
            let kids = adjMap.get(e)
            if (kids != undefined) {
                for (let it of kids) {
                    let old = inDegree.get(it)! - 1
                    inDegree.set(it, old)
                    if (old == 0) {
                        queue.push(it)
                    }
                }
            }
        }

        if (result.length < input.length) {
            let cycle = []
            for (let it of input) {
                if (!result.includes(it)) {
                    cycle.push(it)
                }
            }
            console.log(`CYCLE: ${cycle.map(it => `${this.table.computeTargetName(it, false)}: ${adjMap.get(it)?.map(it => this.table.computeTargetName(it, false)).join(",")}`).join("\n")}`)
            throw new Error("cycle detected")
        }
        console.log("DEPS", result.map(it => this.table.computeTargetName(it, false)).join(","))
        return result
    }
}