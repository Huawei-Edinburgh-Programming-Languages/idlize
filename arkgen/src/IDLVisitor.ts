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
import * as ts from "typescript"
import * as path from "path"
import { OptionValues } from "commander"
import * as idl from "@idlize/core/idl"
import {
    getComment,
    identName,
    GenericVisitor,
    generateSyntheticIdlNodeName,
} from "@idlize/core"
import { PeerGeneratorConfig } from "./peer-generation/PeerGeneratorConfig"
import { ReferenceResolver } from "@idlize/core"
import { IDLVisitorConfig } from "./IDLVisitorConfig"
import { NodeToIDLConverter } from "./NodeToIDLConverter";

export class NameSuggestion {
    protected constructor(
        readonly name: string,
        readonly forced: boolean = false,
    ) { }

    extend(postfix: string, forced: boolean = false): NameSuggestion {
        return new NameSuggestion(
            `${this.name}_${postfix}`,
            forced,
        )
    }

    prependType(): NameSuggestion {
        return new NameSuggestion(`Type_${this.name}`)
    }

    static make(name: string, forced: boolean = false): NameSuggestion {
        return new NameSuggestion(name, forced)
    }
}

export function generateSyntheticFunctionName(parameters: idl.IDLParameter[], returnType: idl.IDLType, isAsync: boolean = false): string {
    let prefix = isAsync ? "AsyncCallback" : "Callback"
    const names = parameters.map(it => `${generateSyntheticIdlNodeName(it.type!)}`).concat(generateSyntheticIdlNodeName(returnType))
    return `${prefix}_${names.join("_").replaceAll(".", "_")}`
}

export const TypeParameterMap: Map<string, Map<string, idl.IDLType>> = new Map([
    ["TransitionEffect", new Map<string, idl.IDLType>([
        ["Type", idl.IDLStringType],
        ["Effect", idl.createReferenceType("TransitionEffects")]])],
    ["ProgressOptions", new Map([
        ["Type", idl.createReferenceType("ProgressType")]])],
    ["ProgressInterface", new Map([
        ["Type", idl.createReferenceType("ProgressType")]])],
    ["ProgressAttribute", new Map<string, idl.IDLType>([
        ["Type", idl.createReferenceType("ProgressType")],
        ["Style", idl.createUnionType([
            idl.createReferenceType("LinearStyleOptions"),
            idl.createReferenceType("RingStyleOptions"),
            idl.createReferenceType("CapsuleStyleOptions"),
            idl.createReferenceType("ProgressStyleOptions")],
            "Union_LinearStyleOptions_RingStyleOptions_CapsuleStyleOptions_ProgressStyleOptions")]])],
])

export class Context {
    typeParameterMap: Map<string, idl.IDLType | undefined> | undefined

    enter(entityName: string) {
        this.typeParameterMap = TypeParameterMap.get(entityName)
    }
}

export class IDLVisitor implements GenericVisitor<idl.IDLEntry[]> {
    private output: idl.IDLEntry[] = []
    imports: idl.IDLImport[] = []
    exports: string[] = []
    namespaces: string[] = []
    globalConstants: idl.IDLConstant[] = []
    globalFunctions: idl.IDLMethod[] = []
    private readonly defaultPackage: string
    private idlConvertor: NodeToIDLConverter

    constructor(
        private sourceFile: ts.SourceFile,
        private typeChecker: ts.TypeChecker,
        private options: OptionValues,
        private predefinedTypeResolver?: ReferenceResolver,
        idlConvertorFactory: NodeToIDLConverterFactory = new DefaultIDLConverterFactory(),
    ) {
        this.defaultPackage = options.defaultIdlPackage as string ?? "arkui"
        this.idlConvertor = idlConvertorFactory.create(
            this.sourceFile,
            this.typeChecker,
            this.options,
            this.namespaces,
            this.predefinedTypeResolver)
    }

    visitWholeFile(): idl.IDLEntry[] {
        ts.forEachChild(this.sourceFile, (node) => this.visit(node))
        this.addMeta()
        if (this.globalConstants.length > 0 || this.globalFunctions.length > 0) {
            this.output.push(idl.createInterface(
                `GlobalScope_${path.basename(this.sourceFile.fileName).replace(".d.ts", "").replaceAll("@", "").replaceAll(".", "_")}`,
                idl.IDLInterfaceSubkind.Interface,
                [],
                [],
                this.globalConstants,
                [],
                this.globalFunctions,
                [], [], {
                extendedAttributes: [ {name: idl.IDLExtendedAttributes.GlobalScope } ],
                fileName: this.sourceFile.fileName
            }))
        }
        return this.output
    }

    addMeta(): void {
        let header = []
        const packageInfo = idl.createPackage(this.detectPackageName(this.sourceFile))
        header.push(packageInfo)
        this.imports.forEach(it => header.push(it))
        this.output.splice(0, 0, ...header)
    }

    detectPackageName(sourceFile: ts.SourceFile): string {
        let ns = sourceFile.statements.find(it => ts.isModuleDeclaration(it)) as ts.ModuleDeclaration
        if (ns) {
            let name = ns.name.text
            if (name.startsWith("./")) name = name.substring(2)
            return name
        }
        let sourceFileName = path.basename(sourceFile.fileName)
        if (sourceFileName.startsWith("@ohos")) {
            let result = sourceFileName.split(".")
            return result.splice(0, result.length - 3).join(".")
        }
        if (sourceFile.fileName.indexOf("\@internal/component") != -1) return "@ohos.arkui"
        return this.defaultPackage
    }

    /** visit nodes finding exported classes */
    visit(node: ts.Node) {
        if (ts.isClassDeclaration(node) ||
            ts.isInterfaceDeclaration(node) ||
            ts.isTypeAliasDeclaration(node) ||
            ts.isFunctionDeclaration(node)) {
            const name = identName(node.name)
            if (name && IDLVisitorConfig.DeletedDeclarations.includes(name)) {
                return
            }
            if (name && IDLVisitorConfig.StubbedDeclarations.includes(name)) {
                this.output.push(this.idlConvertor.serializeStubbed(node))
                return
            }
            if (name && IDLVisitorConfig.ReplacedDeclarations.has(name)) {
                this.output.push({
                    fileName: node.getSourceFile().fileName,
                    ...IDLVisitorConfig.ReplacedDeclarations.get(name)!,
                })
                return
            }
        }
        if (ts.isClassDeclaration(node)) {
            const entry = this.idlConvertor.serializeClass(node)
            if (!PeerGeneratorConfig.ignoreComponents.includes(idl.getExtAttribute(entry, idl.IDLExtendedAttributes.Component) ?? ""))
                this.output.push(entry)
        } else if (ts.isInterfaceDeclaration(node)) {
            const entry = this.idlConvertor.serializeInterface(node)
            if (!PeerGeneratorConfig.ignoreComponents.includes(idl.getExtAttribute(entry, idl.IDLExtendedAttributes.Component) ?? ""))
                this.output.push(entry)
        } else if (ts.isModuleDeclaration(node)) {
            if (this.isKnownAmbientModuleDeclaration(node)) {
                this.output.push(this.idlConvertor.serializeAmbientModuleDeclaration(node))
            } else {
                // This is a namespace, visit its children
                if (node.body) {
                    this.namespaces.unshift(node.name.getText())
                    ts.forEachChild(node.body, (node) => this.visit(node));
                    this.namespaces.shift()
                }
            }
        } else if (ts.isEnumDeclaration(node)) {
            this.output.push(this.idlConvertor.serializeEnum(node))
        } else if (ts.isTypeAliasDeclaration(node)) {
            const typedef = this.idlConvertor.serializeTypeAlias(node)
            if (typedef)
                this.output.push(typedef)
        } else if (ts.isFunctionDeclaration(node)) {
            const method = this.idlConvertor.serializeMethod(node, undefined, true)
            this.globalFunctions.push(method)
        } else if (ts.isVariableStatement(node)) {
            this.globalConstants.push(...this.idlConvertor.serializeConstants(node)) // TODO: Initializers are not allowed in ambient contexts (d.ts).
        } else if (ts.isImportDeclaration(node)) {
            this.imports.push(this.idlConvertor.serializeImport(node))
        } else if (ts.isExportDeclaration(node)) {
            this.exports.push(node.getText())
        } else if (ts.isExportAssignment(node)) {
        } else if (ts.isImportEqualsDeclaration(node)) {
        } else if (ts.isEmptyStatement(node)) {
        } else if (node.kind == ts.SyntaxKind.EndOfFileToken) {
        } else {
            throw new Error(`Unknown node type: ${node.kind}`)
        }

        this.output.push(...this.idlConvertor.getSynthetics())
        this.output.forEach(idl.transformMethodsReturnPromise2Async)
        this.globalFunctions.forEach(idl.transformMethodsReturnPromise2Async)
    }

    private isKnownAmbientModuleDeclaration(type: ts.Node): boolean {
        if (!ts.isModuleDeclaration(type)) return false
        const name = identName(type)
        const ambientModuleNames = this.typeChecker.getAmbientModules().map(it => it.name.replaceAll('\"', ""))
        return name != undefined && ambientModuleNames.includes(name)
    }
}

export function getDocumentation(sourceFile: ts.SourceFile, node: ts.Node, docsOption: string | undefined): string | undefined {
    switch (docsOption) {
        case 'all': return getComment(sourceFile, node)
        case 'opt': return dedupDocumentation(getComment(sourceFile, node))
        case 'none': case undefined: return undefined
        default: throw new Error(`Unknown option docs=${docsOption}`)
    }
}

function dedupDocumentation(documentation: string): string {
    let seen: Set<string> = new Set()
    let firstLine = false
    return documentation
        .split('\n')
        .filter(it => {
            let t = it.trim()
            if (t.startsWith('/*')) {
                firstLine = true
                return true
            }
            if (t == '' || t === '*') {
                // skip empty line at start of a comment
                return !firstLine
            }
            if (t.startsWith('*/')) return true
            if (!seen.has(it)) {
                seen.add(it)
                firstLine = false
                return true
            }
            return false
        })
        .join('\n')
}

export interface NodeToIDLConverterFactory {
    create(sourceFile: ts.SourceFile,
           typeChecker: ts.TypeChecker,
           options: OptionValues,
           namespaces: string[],
           predefinedTypeResolver?: ReferenceResolver): NodeToIDLConverter
}

class DefaultIDLConverterFactory implements NodeToIDLConverterFactory {
    create(sourceFile: ts.SourceFile,
           typeChecker: ts.TypeChecker,
           options: OptionValues,
           namespaces: string[],
           predefinedTypeResolver?: ReferenceResolver): NodeToIDLConverter {
        return new NodeToIDLConverter(sourceFile, options, typeChecker, predefinedTypeResolver, namespaces)
    }
}
