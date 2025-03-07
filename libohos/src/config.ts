/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import * as fs from 'node:fs'
import * as path from 'node:path'
import * as idl from "@idlizer/core/idl"
import ts from "typescript"
import { D, CoreConfigurationSchema, ConfigTypeInfer, ConfigSchema, mergeJSONs, throwException, identName, toIDLFile, Language, isDefined, setCoreConfiguration, resolveJSONPaths } from "@idlizer/core"

////////////////////////////////////////////////////////////////
// Data

const T = {
    stringArray: () => D.array(D.string())
}

export const IDLVisitorConfigurationSchema = D.object({
    DeletedDeclarations: T.stringArray(),
    StubbedDeclarations: T.stringArray(),
    NameReplacements: D.map(D.string(), D.array(D.tuple(D.string(), D.string()))),
    TypeReplacementsFilePath: D.string()
})

export const PeerGeneratorConfigurationSchema = D.combine(
    CoreConfigurationSchema,
    D.object({
        GenerateUnused: D.boolean(),
        ApiVersion: D.number(),
        dumpSerialized: D.boolean(),
        boundProperties: D.map(D.string(), T.stringArray()),

        cppPrefix: D.string(),
        components: D.object({
            ignoreComponents: T.stringArray(),
            ignorePeerMethod: T.stringArray(),
            invalidAttributes: T.stringArray(),
            customNodeTypes: T.stringArray(),
            ignoreEntry: T.stringArray(),
            ignoreEntryJava: T.stringArray(),
            ignoreMethodArkts: T.stringArray(),
            custom: T.stringArray(),
            handWritten: T.stringArray(),
            replaceThrowErrorReturn: T.stringArray(),
        }),
        dummy: D.object({
            ignoreMethods: D.map(D.string(), T.stringArray())
        }),
        materialized: D.object({
            ignoreReturnTypes: T.stringArray(),
        }),
        serializer: D.object({
            ignore: T.stringArray()
        }),
        constants: D.default(
            D.map(D.string(), D.string()),
            new Map()
        ),
        patchMaterialized: D.default(
            D.map(D.string(), D.map(D.string(), D.string())),
            new Map()
        ),
        CollapseOverloadsARKTS: D.boolean(),
        IDLVisitor: IDLVisitorConfigurationSchema,
    })
)

////////////////////////////////////////////////////////////////
// Types

export type IDLVisitorConfiguration = ConfigTypeInfer<typeof IDLVisitorConfigurationSchema>
export type PeerGeneratorConfiguration = ConfigTypeInfer<typeof PeerGeneratorConfigurationSchema>

////////////////////////////////////////////////////////////////
// The configuration

class OneConfigToRuleThemAll {

    ////////////////
    // state

    private TypeReplacementsFile = idl.createFile([])

    ////////////////
    // data fields

    public options: PeerGeneratorConfiguration

    // TODO: should moved to data
    public ReplacedDeclarations = new Map<string, idl.IDLEntry>([
        ["CustomBuilder", idl.createCallback("CustomBuilder", [], idl.IDLVoidType)],
    ])
    // TODO: should moved to data ???
    public linter = {
        // Should user have control over this map?
        // Maybe it belongs to generator and we should move it to linter?
        validEntryAttributes: new Map([
            [idl.IDLKind.Property, ["Optional", "Accessor", "Deprecated", "CommonMethod", "Protected", "DtsName"]],
            [idl.IDLKind.Interface, ["Predefined", "TSType", "CPPType", "Entity", "Interfaces", "ParentTypeArguments", "Component", "Synthetic", "Deprecated", "HandWrittenImplementation"]],
            [idl.IDLKind.Callback, ["Async", "Synthetic"]],
            [idl.IDLKind.Method, ["Optional", "DtsTag", "DtsName", "Throws", "Deprecated", "IndexSignature", "Protected"]],
            [idl.IDLKind.Callable, ["CallSignature", "Deprecated"]],
            [idl.IDLKind.Typedef, ["Import"]],
            [idl.IDLKind.Enum, ["Deprecated"]],
            [idl.IDLKind.EnumMember, ["OriginalEnumMemberName", "Deprecated"]],
            [idl.IDLKind.Constructor, ["Deprecated",]]
        ]),
        checkEnumsConsistency: true,
        checkReferencesResolved: false,
    }

    ////////////////
    // helpers

    public isDeletedDeclaration(name: string) {
        return this.options.IDLVisitor.DeletedDeclarations.includes(name)
    }
    public isStubbedDeclaration(name: string) {
        return this.options.IDLVisitor.StubbedDeclarations.includes(name)
    }
    public getReplacedDeclaration(name: string) {
        return this.ReplacedDeclarations.get(name)
    }
    public checkPropertyTypeReplacement(property: ts.PropertyDeclaration | ts.PropertySignature): [idl.IDLType?, idl.IDLEntry?] {
        const parent = property.parent
        if (!ts.isClassDeclaration(parent) && !ts.isInterfaceDeclaration(parent)) return []
        const className = identName(parent.name)!
        const propertyName = identName(property.name)!
        const entries: idl.IDLInterface[] = this.TypeReplacementsFile.entries.filter((it: idl.IDLEntry) => idl.isInterface(it)) as idl.IDLInterface[]
        const result = entries.find(it => it.name === className)?.properties.find((it: idl.IDLProperty) => it.name == propertyName)
        if (result) {
            let syntheticEntry: idl.IDLEntry | undefined
            if (idl.isReferenceType(result.type)) {
                syntheticEntry = findSyntheticDeclaration(this.TypeReplacementsFile, result.type.name)
            }
            console.log(`Replaced type for ${className}.${propertyName}`)
            return [result.type, syntheticEntry]
        }
        return []
    }
    public checkParameterTypeReplacement(parameter: ts.ParameterDeclaration): [idl.IDLType?, idl.IDLEntry?] {
        const method = parameter.parent
        if (!ts.isClassDeclaration(method.parent) && !ts.isInterfaceDeclaration(method.parent)) return []
        const parameterName = identName(parameter.name)!
        const methodName = identName(method.name)!
        const classOrInterfaceName = identName(method.parent.name)!
        const entries: idl.IDLInterface[] = this.TypeReplacementsFile.entries.filter((it: idl.IDLEntry) => idl.isInterface(it)) as idl.IDLInterface[]
        const result = entries.find(it => it.name === classOrInterfaceName)?.methods.find((it: idl.IDLMethod) => it.name == methodName)?.parameters.find((it: idl.IDLParameter) => it.name == parameterName)
        if (result) {
            let syntheticEntry: idl.IDLEntry | undefined
            if (idl.isReferenceType(result.type)) {
                syntheticEntry = findSyntheticDeclaration(this.TypeReplacementsFile, result.type.name)
            }
            console.log(`Replaced type for ${classOrInterfaceName}.${methodName}(...${parameterName}...)`)
            return [idl.maybeOptional(result.type, result.isOptional), syntheticEntry]
        }
        return []
    }
    public checkTypedefReplacement(typedef: ts.TypeAliasDeclaration): [idl.IDLType?, idl.IDLEntry?] {
        const typename = identName(typedef.name)!
        let entries: idl.IDLTypedef[] = this.TypeReplacementsFile.entries.filter(it => idl.isTypedef(it)) as idl.IDLTypedef[]
        const result = entries.find(it => it.name == typename)
        if (result) {
            let syntheticEntry: idl.IDLEntry | undefined
            if (idl.isReferenceType(result.type)) {
                syntheticEntry = findSyntheticDeclaration(this.TypeReplacementsFile, result.type.name)
            }
            if (idl.isUnionType(result.type)) {
                result.type.name = result.name
            }
            console.log(`Replaced type for typedef ${typename}`)
            return [result.type, syntheticEntry]
        }
        return []
    }
    public checkNameReplacement(name: string, file: ts.SourceFile): string {
        const filename: string = path.basename(file.fileName)
        const replacementPair = this.options.IDLVisitor.NameReplacements.get(filename)
        if (replacementPair) {
            if (replacementPair[0][0] === name) {
                console.log(`Replaced "${name}" with "${replacementPair[1]}" in ${filename}`)
                return replacementPair[0][1]
            }
        }
        return name
    }
    public mapComponentName(originalName: string): string {
        if (originalName.endsWith("Attribute"))
            return originalName.substring(0, originalName.length - 9)
        return originalName
    }
    public ignoreEntry(name: string, language: Language): boolean {
        return this.options.components.ignoreEntry.includes(name) ||
            language === Language.JAVA && this.options.components.ignoreEntryJava.concat(this.options.components.custom).includes(name)
    }
    public ignoreMethod(name: string, language: Language): boolean {
        return language === Language.ARKTS && this.options.components.ignoreMethodArkts.includes(name)
    }
    public isHandWritten(component: string): boolean {
        return this.options.components.handWritten.concat(this.options.components.custom).includes(component)
    }
    public isKnownParametrized(name: string | undefined): boolean {
        return name != undefined && this.options.parameterized.includes(name)
    }
    public isShouldReplaceThrowingError(name: string): boolean {
        for (const ignore of this.options.components.replaceThrowErrorReturn) {
            if (name.endsWith(ignore)) return true
        }
        return false
    }
    public noDummyGeneration(component: string, method?: string): boolean {
        const ignoreMethods = this.options.dummy.ignoreMethods.get(component)
        if (!isDefined(ignoreMethods)) return false
        if (isWhole(ignoreMethods)) return true
        if (method && ignoreMethods.includes(method)) return true
        return false
    }

    ////////////////

    private reloadConfig() {
        setCoreConfiguration(this.options)
    }
    public patch(config: Partial<PeerGeneratorConfiguration>) {
        this.options = Object.assign({}, this.options, config)
        this.reloadConfig()
    }
    public withPatch(config: Partial<PeerGeneratorConfiguration>, op: () => void) {
        const old = this.options
        this.patch(config)
        op()
        this.options = old
        this.reloadConfig()
    }

    ////////////////

    private constructor(
        private configFiles: string,
        private ignoreDefaultConfig: boolean,
    ) {
        this.options = loadPeerConfiguration(
            this.configFiles,
            this.ignoreDefaultConfig
        )
        const typeReplacementsFile = toIDLFile(this.options.IDLVisitor.TypeReplacementsFilePath)
        if (typeReplacementsFile) {
            this.TypeReplacementsFile = typeReplacementsFile
        }
        this.reloadConfig()
    }

    private static _instance?: OneConfigToRuleThemAll = undefined
    public static get current() {
        return this._instance ?? throwException("No config was loaded!")
    }
    public static load(configFiles: string, ignoreDefaultConfig: boolean = false) {
        if (OneConfigToRuleThemAll._instance) {
            if (OneConfigToRuleThemAll._instance.configFiles === configFiles && OneConfigToRuleThemAll._instance.ignoreDefaultConfig === ignoreDefaultConfig) {
                return
            }
        }
        OneConfigToRuleThemAll._instance = new OneConfigToRuleThemAll(configFiles, ignoreDefaultConfig)
    }
}
export const GeneratorConfig = OneConfigToRuleThemAll

////////////////////////////////////////////////////////////////
// Helpers

function findSyntheticDeclaration(file: idl.IDLFile, declName: string): idl.IDLEntry | undefined {
    return file.entries.filter(it => idl.isSyntheticEntry(it)).find(it => it.name == declName)
}

function isWhole(methods: string[]): boolean {
    return methods.includes("*")
}

////////////////////////////////////////////////////////////////
// Infrastructure

function parseConfigFile(configurationFile: string): any {
    if (!fs.existsSync(configurationFile)) return undefined

    const data = fs.readFileSync(path.resolve(configurationFile)).toString()
    return JSON.parse(data)
}

function readConfigFiles(configurationFiles?: string, ignoreDefaultConfig = false): unknown[] {
    const files = ignoreDefaultConfig ? [] : [
        path.join(__dirname, "..", "generation-config", "config.json"),
        path.join(__dirname, "..", "generation-config", "idl-config.json")
    ]
    if (configurationFiles) {
        files.push(...configurationFiles.split(","))
    }

    return files.map(filePath => resolveJSONPaths(
        [
            'IDLVisitor.TypeReplacementsFilePath'
        ],
        filePath,
        parseConfigFile(filePath)
    ))
}

function parseConfigFiles<T>(schema: ConfigSchema<T>, configurationFiles?: string, ignoreDefaultConfig = false): T {
    const json = mergeJSONs(
        readConfigFiles(configurationFiles, ignoreDefaultConfig)
    )
    const result = schema.validate(json)
    if (!result.success()) {
        throw new Error("Configuration is not valid!\n" + result.error() + '\n')
    }
    return result.unwrap()
}

function loadPeerConfiguration(configurationFiles?: string, ignoreDefaultConfig = false): PeerGeneratorConfiguration {
    return parseConfigFiles(PeerGeneratorConfigurationSchema, configurationFiles, ignoreDefaultConfig)
}
