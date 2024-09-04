import { Field, mangleMethodName, Method, MethodModifier } from "../peer-generation/LanguageWriters"
import { capitalize } from "../util"
import { ArgConvertor, RetConvertor } from "./SkoalaConvertors"
import { ImportFeature } from "./SkoalaLibrary"
import * as ts from "typescript"

export class WrapperMethod {
    constructor(
        public originalParentName: string,
        // public declarationTargets: DeclarationTarget[],
        public method: Method,
        public argConvertors?: ArgConvertor[],
        public retConvertor?: RetConvertor,
        public isCallSignature?: boolean,
        public isOverloaded?: boolean,
        public index?: number,
    ) { }

    public hasReceiver(): boolean {
        return !this.method.modifiers?.includes(MethodModifier.STATIC)
    }

    get overloadedName(): string {
        return this.isOverloaded ? mangleMethodName(this.method, this.index) : this.method.name
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
        return this.method.name
    }

    get dummyReturnValue(): string | undefined {
        return undefined
    }

    get retType(): string {
        return "void"
        // return this.maybeCRetType(this.retConvertor) ?? "void"
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

    maybeCRetType(retConvertor: RetConvertor): string | undefined {
        if (retConvertor.isVoid) return undefined
        return retConvertor.nativeType()
    }

    generateAPIParameters(): string[] {
        return []
        // const args = this.argConvertors.map(it => {
        //     let isPointer = it.isPointerType()
        //     return `${isPointer ? "const ": ""}${it.nativeType(false)}${isPointer ? "*": ""} ${it.param}`
        // })
        // const receiver = this.generateReceiver()
        // if (receiver) return [`${receiver.argType} ${receiver.argName}`, ...args]
        // return args
    }

    generateReceiver(): {argName: string, argType: string} | undefined {
        if (!this.hasReceiver()) return undefined
        return {
            argName: "node",
            argType: "NativePointer"
        }
    }

    static markOverloads(methods: WrapperMethod[]): void {
        for (const method of methods)
            method.isOverloaded = false

        for (const method of methods) {
            if (method.isOverloaded) continue
            const sameNamedMethods = methods.filter(it => it.method.name === method.method.name)
            if (sameNamedMethods.length <= 1) continue
            sameNamedMethods.forEach((method) => method.isOverloaded = true)
        }
    }
}

export class WrapperField {
    constructor(
        // public declarationTarget: DeclarationTarget,
        public field: Field,
        public argConvertor?: ArgConvertor,
        public retConvertor?: RetConvertor,
    ) { }
}

export class WrapperClass {
    constructor(
        public readonly className: string,
        public readonly isInterface: boolean,
        public readonly superClass: WrapperClass | ts.InterfaceDeclaration | ts.ClassDeclaration | string,
        public readonly isSuperClassWrapper: boolean,
        public readonly fields: WrapperField[],
        public readonly ctor: WrapperMethod | undefined,
        public readonly finalizer: WrapperMethod,
        public readonly importFeatures: ImportFeature[],
        public readonly methods: WrapperMethod[],
        public readonly needBeGenerated: boolean = true,
    ) {
        // PeerMethod.markOverloads(methods)
    }

    getComponentName(): string {
        return this.className
    }
}