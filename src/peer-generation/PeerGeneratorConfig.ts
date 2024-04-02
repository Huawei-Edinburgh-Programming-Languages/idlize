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
import { defaultCompilerOptions } from "../util";
import * as ts from "typescript";

export class PeerGeneratorConfig {
    public static commonMethod = ["CommonMethod"]

    public static ignoreSerialization = ["Array", "Callback", "ErrorCallback", "Length", "AttributeModifier"]
    public static ignorePeerMethod = ["attributeModifier"]

    private static knownParametrized = ["Indicator", "AttributeModifier"]

    public static readonly rootComponents = [
        "CommonMethod",
        "SecurityComponentMethod"
    ]

    // Will figure out what to do with those later, currently will extend PeerNode
    public static readonly standaloneComponents = [
        "CalendarAttribute",
        "ContainerSpanAttribute"
    ]

    public static readonly serializerBaseMethods = serializerBaseMethods()

    public static skipPeerGeneration = ["CommonAttribute"]

    static mapComponentName(originalName: string): string {
        if (originalName.endsWith("Attribute"))
            return originalName.substring(0, originalName.length - 9)
        return originalName
    }

    static isKnownParametrized(name: string | undefined) : boolean {
        return name != undefined && PeerGeneratorConfig.knownParametrized.includes(name)
    }
}

function serializerBaseMethods(): string[] {
    const program = ts.createProgram([
        "./utils/ts/SerializerBase.ts",
        "./utils/ts/types.ts",
    ], defaultCompilerOptions)

    const serializerDecl = program.getSourceFiles()
        .find(it => it.fileName.includes("SerializerBase"))
    if (serializerDecl === undefined) throw new Error("Didn't find SerializerBase")

    const methods: string[] = []
    visit(serializerDecl)
    return methods

    function visit(node: ts.Node) {
        if (ts.isSourceFile(node)) node.statements.forEach(visit)
        if (ts.isClassDeclaration(node)) node.members.filter(ts.isMethodDeclaration).forEach(visit)
        if (ts.isMethodDeclaration(node)) methods.push(node.name.getText(serializerDecl))
    }
}
