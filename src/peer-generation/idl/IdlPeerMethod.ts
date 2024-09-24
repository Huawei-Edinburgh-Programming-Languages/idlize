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


import { capitalize, isDefined } from "../../util"
import { ArgConvertor, RetConvertor } from "./IdlArgConvertors"
import { Method, MethodModifier, NamedMethodSignature, copyMethod, mangleMethodName } from "../LanguageWriters"
import { PrimitiveType } from "../DeclarationTable"
import { IDLType } from "../../idl"

export class IdlPeerMethod {
    private overloadIndex?: number
    constructor(
        public originalParentName: string,
        public originalDeclarationTargets: IDLType[],
        public originalArgConvertors: ArgConvertor[],
        public retConvertor: RetConvertor,
        public isCallSignature: boolean,
        public originalMethod: Method,
        public peerArgsFilter: ((method: IdlPeerMethod, index: number) => boolean) | undefined,
    ) { }

    public get peerDeclarationTargets(): IDLType[] {
        return this.originalDeclarationTargets.filter((it, index) => this.peerArgsFilter?.(this, index) ?? true)
    }
    public get peerArgConvertors(): ArgConvertor[] {
        return this.originalArgConvertors.filter((it, index) => this.peerArgsFilter?.(this, index) ?? true)
    }
    public get peerMethod(): Method {
        if (!this.peerArgsFilter)
            return this.originalMethod
        const signature = this.originalMethod.signature
        return copyMethod(this.originalMethod, {
            signature: new NamedMethodSignature(
                signature.returnType,
                signature.args
                    .filter((it, index) => this.peerArgsFilter!(this, index)),
                signature.args.map((_, index) => signature.argName(index))
                    .filter((it, index) => this.peerArgsFilter!(this, index)),
                signature.defaults
            )
        })
    }

    get overloadedName(): string {
        return mangleMethodName(this.peerMethod, this.overloadIndex)
    }
    get fullMethodName(): string {
        return this.isCallSignature ? this.overloadedName : this.peerMethodName
    }
    get peerMethodName() {
        const name = this.overloadedName
        if (!this.hasReceiver()) return name
        if (name.startsWith("set") ||
            name.startsWith("get")
        ) return name
        return `set${capitalize(name)}`
    }
    get implNamespaceName(): string {
        return `${capitalize(this.originalParentName)}Modifier`
    }
    get implName(): string {
        return `${capitalize(this.overloadedName)}Impl`
    }
    get toStringName(): string {
        return this.peerMethod.name
    }
    get dummyReturnValue(): string | undefined {
        return undefined
    }
    get retType(): string {
        return this.maybeCRetType(this.retConvertor) ?? "void"
    }
    get receiverType(): string {
        return "Ark_NodeHandle"
    }
    get apiCall(): string {
        return "GetNodeModifiers()"
    }
    get apiKind(): string {
        return "Modifier"
    }

    hasReceiver(): boolean {
        return !this.peerMethod.modifiers?.includes(MethodModifier.STATIC)
    }

    maybeCRetType(retConvertor: RetConvertor): string | undefined {
        if (retConvertor.isVoid) return undefined
        return retConvertor.nativeType()
    }

    generateAPIParameters(): string[] {
        const args = this.peerArgConvertors.map(it => {
            let isPointer = it.isPointerType()
            return `${isPointer ? "const ": ""}${it.nativeType(false)}${isPointer ? "*": ""} ${it.param}`
        })
        const receiver = this.generateReceiver()
        if (receiver) return [`${receiver.argType} ${receiver.argName}`, ...args]
        return args
    }

    generateReceiver(): {argName: string, argType: string} | undefined {
        if (!this.hasReceiver()) return undefined
        return {
            argName: "node",
            argType: PrimitiveType.NativePointer.getText()
        }
    }

    static markOverloads(methods: IdlPeerMethod[]): void {
        for (const peerMethod of methods) {
            if (isDefined(peerMethod.overloadIndex)) continue
            const sameNamedMethods = methods.filter(it => it.peerMethod.name === peerMethod.peerMethod.name)
            if (sameNamedMethods.length > 1)
                sameNamedMethods.forEach((it, index) => it.overloadIndex = index)
        }
    }
}
