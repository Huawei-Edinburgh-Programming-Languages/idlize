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

import { capitalize, collapseTypes, flattenUnionType, generateSyntheticFunctionName, generateSyntheticIdlNodeName, IDLFile, IDLLibrary, IDLMethod, Language, lib, PeerLibrary, resolveNamedNode, throwException } from "@idlizer/core"
import * as arkts from "@koalaui/libarkts"
import * as idl from "@idlizer/core/idl"
import * as path from "node:path"
import * as fs from "node:fs"
import { ETSVisitorConfig } from "./config"

function processFile(outDir: string, baseDir: string, file: string, config:ETSVisitorConfig): IDLSuperFile {
    let input = fs.readFileSync(file).toString()
    //let module = arkts.createETSModuleFromSource(input, arkts.Es2pandaContextState.ES2PANDA_STATE_PARSED)
    const configPath = path.resolve(__dirname, "..", "config.json")
    const configText = fs.readFileSync(configPath, 'utf-8')
    const configContent = JSON.parse(configText)
    const paths = configContent.compilerOptions.paths ?? {};
    const pathMap = new Map()
    for (const key in paths) {
        pathMap.set(key, path.normalize(path.join(path.dirname(configPath), paths[key][0])))
    }
    arkts.arktsGlobal.filePath = file
    arkts.arktsGlobal.config = arkts.Config.create([
        '_',
        '--arktsconfig',
        configPath,
        file,
        '--extension',
        'ets',
        '--stdlib',
        path.join(process.env.PANDA_SDK_PATH as string, 'ets', 'stdlib'),
        '--output',
        'a.abc'
    ]).peer
    arkts.arktsGlobal.compilerContext = arkts.Context.createFromString(input)
    arkts.proceedToState(arkts.Es2pandaContextState.ES2PANDA_STATE_PARSED)
    const script = arkts.createETSModuleFromContext()
    let idlVisitor = new IDLVisitor(baseDir, file, pathMap, config)
    idlVisitor.visitor(script)
    const idlFile = idlVisitor.toIDLSuperFile()
    const fileRelativePath = path.relative(baseDir, file)
    const outFile = path.join(outDir, fileRelativePath.replace(".d.ets", ".idl"))
    idlFile.writeFilePath = outFile
    return idlFile
}

export interface GenerateFromSTSContext {
    inputFiles: string[]
    baseDir: string
    outDir: string
    config: ETSVisitorConfig
}

export function generateFromSts(config: GenerateFromSTSContext): PeerLibrary {
    if (!process.env.PANDA_SDK_PATH) {
        process.env.PANDA_SDK_PATH = path.resolve(__dirname, "../../node_modules/@panda/sdk")
    }
    console.log(`Use Panda from ${process.env.PANDA_SDK_PATH}`)
    console.log('Parsing files...')
    let library = parseFiles(config)
    console.log('Removing synthetics...')
    library = removeSynthetics(library)
    console.log('Adjusting imports...')
    library = adjustImports(library)
    console.log('Synthesizing entries...')
    library = generateSyntheticFiles(library, config)
    writeFiles(library)
    // const doAdjustJob = processLogger(adjusted.length)
    // adjusted.forEach(file => {
    //     const fileName = file.writeFilePath
    //     doAdjustJob(fileName, () => {
    //         const outFileDir = path.dirname(fileName)
    //         if (!fs.existsSync(outFileDir)) {
    //             fs.mkdirSync(outFileDir, { recursive: true })
    //         }
    //         fs.writeFileSync(fileName, idl.toIDLString(file.file, {}), 'utf8')
    //         return file
    //     })
    // })
    return new PeerLibrary(Language.ARKTS)
}

function parseFiles({inputFiles, baseDir, outDir, config}: GenerateFromSTSContext): IDLSuperFile[] {
    const doParseJob = processLogger(inputFiles.length)
    let library: IDLSuperFile[] = []
    inputFiles.forEach(file => {
        try {
            doParseJob(file, () => {
                const idlFile = processFile(outDir, baseDir, file, config)
                library.push(idlFile)
                return 'parsed'
            })
        } catch (e: any) {
            console.log(e)
            if (e.trace)
                console.log(e.trace)
            // But current es2panda just forcefully exits.
            // throw e
        }
    })
    return library
}

function removeSynthetics(library: IDLSuperFile[]): IDLSuperFile[] {
    const conflictingNames = new Set(library.flatMap(it => it.syntheticEntries).map(it => it.syntheticEntry.name))
    function removeConflictingChildren(node: idl.IDLEntry | idl.IDLFile, conflictingNames: Set<string>): void {
        if (idl.isFile(node)) {
            node.entries = node.entries.filter(it => !conflictingNames.has(it.name))
            node.entries.forEach(it => removeConflictingChildren(it, conflictingNames))
        }
        if (idl.isNamespace(node)) {
            node.members = node.members.filter(it => !conflictingNames.has(it.name))
            node.members.forEach(it => removeConflictingChildren(it, conflictingNames))
        }
    }
    library.forEach(file => {
        removeConflictingChildren(file.file, conflictingNames)
    })
    return library
}

function adjustImports(library:IDLSuperFile[]): IDLSuperFile[] {
    const map = new Map<string, IDLSuperFile[]>()
    library.forEach(file => {
        const pkg = file.file.packageClause.join('.')
        if (!map.has(pkg)) {
            map.set(pkg, [])
        }
        map.get(pkg)!.push(file)
    })

    library.forEach((file) => {
        file.file.entries.forEach(entry => {
            if (!idl.isImport(entry)) {
                return
            }
            if (entry.name === "" || entry.clause.length < 2) {
                return
            }

            const fileClause = entry.clause.slice(0, entry.clause.length - 1)
            let fileClauseString = fileClause.join('.')
            let fileExportName = entry.clause.at(-1)!

            let oldFileClauseString = ''
            while (oldFileClauseString !== fileClauseString) {
                const referencedFiles = map.get(fileClauseString)
                if (!referencedFiles) {
                    break
                }
                oldFileClauseString = fileClauseString
                for (const refFile of referencedFiles) {
                    if (refFile.exports.has(fileExportName)) {
                        const clause = refFile.exports.get(fileExportName)!.split('.')
                        if (clause.length < 2) {
                            return
                        }
                        fileClauseString = clause.slice(0, clause.length - 1).join('.')
                        fileExportName = clause.at(-1)!
                        break
                    }
                }
            }
            entry.clause = [...fileClauseString.split('.'), fileExportName]
        })
    })
    return library
}

function equalsClause(a: string[], b: string[]): boolean {
    return a.length === b.length && a.every((it, index) => b[index] === it)
}

function makeSyntheticFileName(filename: string): string {
    return filename.replaceAll('.idl', '').replaceAll('.d.ets', '') + ".synthetic.idl"
}

function generateSyntheticFiles(library: IDLSuperFile[], { config, outDir }: GenerateFromSTSContext): IDLSuperFile[] {
    const idlLibrary = new PeerLibrary(Language.ARKTS, false)
    idlLibrary.files.push(...library.map(it => it.file))
    idlLibrary.files.forEach(idl.linkParentBack)
    const syntheticFiles: IDLSuperFile[] = []
    for (const file of library) {
        const syntheticImports: idl.IDLImport[] = []
        const syntheticEntries: idl.IDLEntry[] = []
        const resolvePov = (clause: string[]): idl.IDLNode => {
            let pov: idl.IDLNode = file.file
            let povEntries: idl.IDLEntry[] = file.file.entries
            for (const slice of clause) {
                for (const entry of povEntries) {
                    if (idl.isNamespace(entry) && entry.name === slice) {
                        pov = entry
                        povEntries = entry.members
                        break
                    }
                }
            }
            return pov
        }
        for (const synthetic of file.syntheticEntries) {
            idl.forEachChild(synthetic.syntheticEntry, (child) => {
                if (idl.isReferenceType(child)) {
                    const resolved = resolveNamedNode(child.name.split('.'), child, idlLibrary.files)
                    if (!resolved) return
                    const resolvedFQN = idl.getFQName(resolved).split('.')
                    const resolvedNamespace = idl.getNamespacesPathFor(resolved).at(-1)
                    let resolvedImportClause: string[]
                    let resolvedRelatireClause: string[]
                    if (resolvedNamespace) {
                        resolvedImportClause = idl.getFQName(resolvedNamespace).split('.')
                        resolvedRelatireClause = resolvedFQN.slice(resolvedImportClause.length - 1)
                    } else {
                        resolvedImportClause = resolvedFQN
                        resolvedRelatireClause = [resolvedFQN.at(-1)!]
                    }
                    if (!syntheticImports.some(it => equalsClause(it.clause, resolvedImportClause)))
                        syntheticImports.push(idl.createImport(resolvedImportClause, resolvedRelatireClause[0]))
                    child.name = resolvedRelatireClause.join('.')
                }
            })
            syntheticEntries.push(synthetic.syntheticEntry)
        }
        syntheticFiles.push({
            exports: new Map(),
            file: idl.createFile([...syntheticImports, ...syntheticEntries], makeSyntheticFileName(file.file.fileName!), config.SyntheticPackage),
            originalFileName: makeSyntheticFileName(file.originalFileName),
            skipped: false,
            syntheticEntries: [],
            writeFilePath: makeSyntheticFileName(file.writeFilePath),
        })
    }
    return [
        ...library,
        ...syntheticFiles,
    ]
}

function writeFiles(library: IDLSuperFile[]): void {
    library.forEach(file => {
        fs.mkdirSync(path.dirname(file.writeFilePath), { recursive: true })
        fs.writeFileSync(file.writeFilePath, idl.toIDLString(file.file, {}), 'utf8')
    })
}

function processLogger(amount: number) {
    let done = 1
    return (fileName: string, op: () => string) => {
        console.log(`[ ${done.toString()}/${amount.toString()} ] Processing ${fileName}`)
        try {
            const outMsg = op()
            console.log(`  ... ${outMsg}`)
        } catch (ex: unknown) {
            console.log(`  ... failed`)
            throw ex
        } finally {
            ++done
        }
    }
}

interface IDLSuperFile {
    originalFileName: string
    writeFilePath: string
    file: IDLFile
    syntheticEntries: SyntheticEntry[]
    skipped: boolean
    exports: Map<string, string>
}

interface ExtractTypeParameterInfo {
    set: Set<string>
    parameters: string[] | undefined,
    attrs: idl.IDLExtendedAttribute[]
}

type SyntheticEntry = { syntheticEntry: idl.IDLEntry, povClause: string[] }

class IDLVisitor extends arkts.AbstractVisitor {
    //writer = new IDLLanguageWriter()
    entries: idl.IDLEntry[] = []
    syntheticEntries: SyntheticEntry[] = []
    fileName: string
    packageClause: string[] = []
    namespacesPath: string[] = []

    private defaultExportName?: string
    private typeParamsStack: Set<string>[] = []

    private fileReExports: Map<string, string> = new Map()

    private detectPackageNameByPath(fileName: string): string[] {
        if (this.importPathMap.has(fileName)) {
            return this.detectPackageNameByPath(this.importPathMap.get(fileName)!)
        }
        return path.relative(this.basePath, fileName)
            .replaceAll('.d.ets', '')
            .replaceAll('.idl', '')
            .split(path.sep)
            .map(it => it.replaceAll('@', ''))
            .map(it => it.split('-').map((it, i) => i === 0 ? it : capitalize(it)).join('')) // kebab-case to camelCase
            .filter(it => it.length && it !== '.' && it !== '..')
    }

    private mode: 'regular' | 'arkoala' = 'arkoala'
    private arkoalaTweaks(op:() => void) {
        if (this.mode === 'arkoala') {
            op()
        }
    }

    constructor(
        protected basePath: string,
        protected originalFileName: string,
        protected importPathMap: Map<string, string>,
        protected config: ETSVisitorConfig,
    ) {
        super()
        this.fileName = this.originalFileName.replace(".d.ets", ".idl")
        this.packageClause = this.detectPackageNameByPath(this.originalFileName)
    }
    visitor(node: arkts.AstNode): arkts.AstNode {

        if (arkts.hasModifierFlag(node, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_DEFAULT_EXPORT)) {
            if (arkts.isInterfaceDecl(node)) {
                this.defaultExportName = node.id!.name
            }
            if (arkts.isTSInterfaceDeclaration(node)) {
                this.defaultExportName = node.id!.name
            }
            if (arkts.isTSModuleDeclaration(node)) {
                this.defaultExportName = (node.name as arkts.Identifier).name // not sure about this
            }
            if (arkts.isETSModule(node)) {
                this.defaultExportName = node.ident?.name
            }
        }

        if (arkts.isExportNamedDeclaration(node)) {
            if (arkts.hasModifierFlag(node, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_DEFAULT_EXPORT) && node.specifiers.length === 1) {
                const [ spec ] = node.specifiers
                this.defaultExportName = spec.local!.name
            }
        }
        if (arkts.isETSReExportDeclaration(node)) {
            let importString = node.eTSImportDeclarations!.source!.str
            if (importString.startsWith('.')) {
                const currentFileBaseDir = path.dirname(this.originalFileName)
                const importFilePath = path.normalize(path.join(currentFileBaseDir, importString))
                importString = importFilePath
            }
            const importedPackageClause = this.detectPackageNameByPath(importString)
            node.eTSImportDeclarations!.specifiers.forEach(spec => {
                if (arkts.isImportSpecifier(spec)) {
                    this.fileReExports.set(spec.local!.name, [...importedPackageClause, spec.imported!.name].join('.'))
                }
            })
        }
        if (arkts.isExportDefaultDeclaration(node)) {
            if (arkts.isIdentifier(node.decl)) {
                this.defaultExportName = node.decl.name
            }
        }

        //////////////////

        if (arkts.isScriptFunction(node)) {
            return this.visitScriptFunction(node)
        }
        if (arkts.isClassDeclaration(node)) {
            return this.visitClassDeclaration(node)
        }
        if (arkts.isInterfaceDecl(node) || arkts.isTSInterfaceDeclaration(node)) {
            return this.visitInterfaceDeclaration(node)
        }
        if (arkts.isImportDeclaration(node)) {
            return this.visitImportDeclaration(node)
        }
        if (arkts.isTSEnumDeclaration(node)) {
            return this.visitEnumDeclaration(node)
        }
        if (arkts.isTSTypeAliasDeclaration(node)) {
            return this.visitTSTypeAliasDeclaration(node)
        }
        if (arkts.isFunctionDeclaration(node)) {
            return this.visitFunctionDeclaration(node)
        }
        if (arkts.isETSModule(node) && node.ident?.name !== 'ETSGLOBAL') {
            return this.visitETSModule(node)
        }

        //////////////////

        return this.visitEachChild(node)
    }

    visitETSModule(node: arkts.ETSModule): arkts.ETSModule {
        const old = this.entries
        this.entries = []
        this.namespacesPath.push(node.ident!.name)
        this.visitEachChild(node)
        this.namespacesPath.pop()
        const members = this.entries
        this.entries = old
        this.entries.push(idl.createNamespace(
            node.ident!.name,
            members,
            { fileName: this.fileName }
        ))
        return node
    }

    visitEnumDeclaration(node: arkts.TSEnumDeclaration): arkts.TSEnumDeclaration {
        const name = node.key!.name
        if (this.config.DeletedDeclarations.includes(name)) {
            return node
        }
        let result = idl.createEnum(name, [], {})
        result.elements =
            node.members.map(it => {
                let element = (it as arkts.TSEnumMember)
                let [type, value] = this.convertEnumInitializer(element.init)
                return idl.createEnumMember(element.name, result, type, value)
            })
        this.entries.push(result)
        return node
    }

    convertEnumInitializer(expression: arkts.Expression | undefined): [idl.IDLPrimitiveType, string | number | undefined] {
        let initializer: string | number | undefined
        let type = idl.IDLNumberType
        if (!expression) {
            return [type, initializer]
        }
        if (arkts.isNumberLiteral(expression) && expression.str !== "") {
            initializer = parseInt(expression.str)
            if (Number.isNaN(initializer)) {
                throw new Error("Initializator is not number!")
            }
        }
        if (arkts.isStringLiteral(expression)) {
            initializer = '"' + expression.str + '"'
            type = idl.IDLStringType
        }
        return [type, initializer]
    }

    visitImportDeclaration(node: arkts.ImportDeclaration): arkts.ImportDeclaration {
        let importString = node.source!.str
        if (importString.startsWith('.')) {
            const currentFileBaseDir = path.dirname(this.originalFileName)
            const importFilePath = path.normalize(path.join(currentFileBaseDir, node.source!.str))
            importString = importFilePath
        }
        const importedPackageClause = this.detectPackageNameByPath(importString)
        if (importedPackageClause.join('.') === this.packageClause.join('.')) {
            return node
        }
        node.specifiers.forEach(spec => {
            if (arkts.isImportSpecifier(spec)) {
                const imported = spec.imported!
                const local = spec.local ?? imported
                this.entries.push(idl.createImport([...importedPackageClause, imported.name], local.name))
            }
            if (arkts.isImportDefaultSpecifier(spec)) {
                this.entries.push(idl.createImport([...importedPackageClause, 'default'], spec.local!.name))
            }
            if (arkts.isImportNamespaceSpecifier(spec)) {
                this.entries.push(idl.createImport([...importedPackageClause, 'default'], spec.local!.name))
            }
        })
        return node
    }

    visitFunctionDeclaration(node: arkts.FunctionDeclaration): arkts.FunctionDeclaration {
        const func = node.function!
        const { set:paramsSet, parameters } = this.extractTypeParameters(func.typeParams)
        this.withTypeParamContext(paramsSet, () => {
            const method = idl.createMethod(
                func.id!.name,
                func.params.map(it => {
                    const param = it as arkts.ETSParameterExpression
                    return idl.createParameter(param.name, this.serializeType(param.typeAnnotation))
                }),
                this.serializeType(func.returnTypeAnnotation),
                {
                    isAsync: func.isAsyncFunc,
                    isFree: true,
                    isOptional: false,
                    isStatic: func.isStaticBlock
                },
                {
                    fileName: this.fileName,
                },
                parameters
            )
            /* arkgen specialization */
            if (node.annotations.find(it => arkts.isIdentifier(it.expr) && it.expr.name === "ComponentBuilder")) {
                this.entries.push(idl.createInterface(
                    method.name + 'Interface',
                    idl.IDLInterfaceSubkind.Interface,
                    [],
                    [],
                    [],
                    [],
                    [],
                    [idl.createCallable(
                        "invoke",
                        method.parameters.slice(0, method.parameters.length - 1),
                        method.returnType,
                        {
                            isAsync: method.isAsync,
                            isStatic: method.isStatic
                        },
                        {
                            extendedAttributes: [
                                { name: idl.IDLExtendedAttributes.CallSignature },
                            ]
                        }
                    )],
                    method.typeParameters,
                    {
                        fileName: this.fileName,
                        extendedAttributes: [
                            { name: idl.IDLExtendedAttributes.ComponentInterface },
                        ]
                    }
                ))
            } else {
                this.entries.push(method)
            }
        })
        return node
    }

    visitTSTypeAliasDeclaration(declaration: arkts.TSTypeAliasDeclaration): arkts.TSTypeAliasDeclaration {
        const name = declaration.id!.name
        if (this.mode === 'arkoala') {
            if (['Length', 'Dimension'].includes(name)) {
                this.entries.push(idl.createTypedef(
                    name,
                    idl.createUnionType([
                        idl.IDLStringType,
                        idl.IDLNumberType,
                        idl.createReferenceType('Resource_')
                    ]),
                    [],
                    {
                        extendedAttributes: [],
                        fileName: this.fileName
                    }
                ))
                return declaration
            }
        }
        const { set:paramsSet, parameters } = this.extractTypeParameters(declaration.typeParams)
        this.withTypeParamContext(paramsSet, () => {
            this.entries.push(idl.createTypedef(
                name,
                this.serializeType(declaration.typeAnnotation),
                parameters,
                {
                    fileName: this.fileName,
                })
            )
        })
        return declaration
    }

    visitScriptFunction(node: arkts.ScriptFunction): arkts.ScriptFunction {
        return this.visitEachChild(node) as arkts.ScriptFunction
    }

    private printNode(node: arkts.AstNode) {
        let name = arkts.isIdentifier(node) ? `'${node.name}'` : ""
        return `${" ".repeat(4 * this.indentation) + node.constructor.name} ${name}`
    }

    private processBody(scopeName:string, members:readonly arkts.AstNode[] | undefined) {
        let hasMemoAnnotation = false
        const properties: idl.IDLProperty[] = []
        const methods: idl.IDLMethod[] = []
        const constructors: idl.IDLConstructor[] = []

        members?.forEach(member => {
            if (arkts.isClassProperty(member)) {
                properties.push(this.serializeClassProperty(member))
                const found = member.annotations.find(ann => arkts.isIdentifier(ann.expr) && ann.expr.name === 'memo')
                if (found) {
                    hasMemoAnnotation = true
                }
                return
            }
            if (arkts.isMethodDefinition(member)) {
                if (this.shouldNotProcessMember(scopeName, member.id!.name)) {
                    return
                }
                const serializedMethod = this.serializeMethod(member)
                if (idl.isConstructor(serializedMethod))
                    constructors.push(serializedMethod)
                else
                    methods.push(serializedMethod)
                const found = member.function!.annotations.find(ann => arkts.isIdentifier(ann.expr) && ann.expr.name === 'memo')
                if (found) {
                    hasMemoAnnotation = true
                }
                return
            }
            console.error(member)
            throw new Error("Unhandled member!")
        })

        return {
            properties,
            constructors,
            methods,
            hasMemoAnnotation,
        }
    }

    visitClassDeclaration(declaration: arkts.ClassDeclaration): arkts.ClassDeclaration {
        const name = declaration.definition!.ident!.name
        if (this.config.DeletedDeclarations.includes(name)) {
            return declaration
        }
        const definition = declaration.definition!
        const { set:paramsSet, parameters } = this.extractTypeParameters(definition.typeParams)
        this.withTypeParamContext(paramsSet, () => {
            const inheritance: idl.IDLReferenceType[] = []
            if (definition.super) {
                const sup = this.serializeType(definition.super)
                if (!idl.isReferenceType(sup)) {
                    throw new Error("Expected reference type")
                }
                inheritance.push(sup)
            }
            if (definition.implements.length) {
                if (inheritance.length === 0) {
                    inheritance.push(idl.IDLTopType)
                }
                definition.implements.forEach(int => {
                    const type = this.serializeType(int.expr)
                    if (!idl.isReferenceType(type)) {
                        throw new Error("Expected reference type")
                    }
                    inheritance.push(type)
                })
            }

            const { properties, methods, constructors } = this.processBody(name, declaration.definition?.body)
            const attrs: idl.IDLExtendedAttribute[] = [
                { name: idl.IDLExtendedAttributes.Entity, value: idl.IDLEntity.Class }
            ]
            this.entries.push(idl.createInterface(
                name,
                idl.IDLInterfaceSubkind.Class,
                inheritance,
                constructors, // ctors
                undefined, // constants
                properties,
                methods,
                [], // callables
                parameters,
                {
                    fileName: this.fileName,
                    extendedAttributes: attrs.length === 0 ? undefined : attrs
                }
            ))
        })
        return declaration
    }

    visitInterfaceDeclaration(declaration: arkts.InterfaceDecl | arkts.TSInterfaceDeclaration): arkts.InterfaceDecl | arkts.TSInterfaceDeclaration {
        const name = declaration.id!.name
        if (this.config.DeletedDeclarations.includes(name)) {
            return declaration
        }
        const { set:paramsSet, parameters } = this.extractTypeParameters(declaration.typeParams)
        this.withTypeParamContext(paramsSet, () => {
            const inheritance: idl.IDLReferenceType[] = []
            if (declaration.extends.length) {
                declaration.extends.forEach(int => {
                    const type = this.serializeType(int.expr)
                    if (!idl.isReferenceType(type)) {
                        throw new Error("Expected reference type")
                    }
                    inheritance.push(type)
                })
            }
            const { properties, methods, constructors } = this.processBody(name, declaration.body?.getChildren())
            const attrs: idl.IDLExtendedAttribute[] = []
            this.entries.push(idl.createInterface(
                name,
                idl.IDLInterfaceSubkind.Interface,
                inheritance,
                constructors, // ctors
                undefined, // constants
                properties,
                methods,
                [], // callables
                parameters,
                {
                    fileName: this.fileName,
                    extendedAttributes: attrs.length === 0 ? undefined : attrs
                }
            ))
        })
        return declaration
    }

    serializeMethod(method: arkts.MethodDefinition): IDLMethod | idl.IDLConstructor {
        const { set:paramsSet, parameters:typeParameters } = this.extractTypeParameters((method.value as arkts.FunctionExpression).function?.typeParams)
        return this.withTypeParamContext(paramsSet, () => {
            const parameters = method.function!.params.map(it => {
                let param = it as arkts.ETSParameterExpression
                return idl.createParameter(param.name, this.serializeType(param.typeAnnotation), param.isOptional)
            })
            const returnType = this.serializeType(method.function!.returnTypeAnnotation!)
            if (method.id!.name === 'constructor') {
                return idl.createConstructor(
                    parameters,
                    returnType,
                )
            }
            return idl.createMethod(method.id!.name,
                parameters,
                returnType,
                {
                    isStatic: !!(method.modifierFlags & arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_STATIC),
                    isAsync: false,
                    isFree: false,
                    isOptional: false,
                },
                undefined /* todo: nodeInitilizer */,
                typeParameters
            )
        })
    }

    serializeClassProperty(property: arkts.ClassProperty): idl.IDLProperty {
        const prop = idl.createProperty((property.key as arkts.Identifier).name, this.serializeType(property.typeAnnotation!))
        if (arkts.hasModifierFlag(property, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_OPTIONAL)) {
            prop.extendedAttributes ??= []
            prop.isOptional = true
            prop.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Optional })
        }
        if (arkts.hasModifierFlag(property, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_STATIC)) {
            prop.isStatic = true
        }
        return prop
    }

    private static etsFunctionTypeReferencePattern = new RegExp(/^Function[0-9]+$/g)
    private static isFunctionTypeReference(name:string) {
        return IDLVisitor.etsFunctionTypeReferencePattern.test(name)
            || name === 'Callback'
    }

    maybeSerializeETSFunctionReference(type: arkts.ETSTypeReference): [idl.IDLCallback, string[]] | undefined {
        let name = type.baseName!.name
        if (!IDLVisitor.isFunctionTypeReference(name)) return undefined
        const [typeArgs, trappedParams] = this.useTypeParametersTrap(() => {
            const typeArgs = type.part?.typeParams?.params.map(it => this.serializeType(it))
            return typeArgs
        })
        const orderedTrappedParams = Array.from(trappedParams)
        const returnType = name === 'Callback' ? idl.IDLVoidType : typeArgs?.at(1) ?? idl.IDLVoidType
        let paramsTypes = name === 'Callback' ? [typeArgs!.at(0)!] : typeArgs?.slice(0, -1)
        if (paramsTypes?.length === 1 && paramsTypes[0] === idl.IDLVoidType) {
            paramsTypes = []
        }
        const parameters = paramsTypes?.map((it, index) => idl.createParameter(`value${index}`, it)) ?? []
        const callback = idl.createCallback(
            generateSyntheticFunctionName(parameters, returnType, arkts.hasModifierFlag(type, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_ASYNC)),
            parameters,
            returnType,
            { fileName: this.fileName },
            orderedTrappedParams.length === 0 ? undefined : orderedTrappedParams,
        )
        return [callback, orderedTrappedParams]
    }

    serializeType(type: arkts.AstNode | undefined): idl.IDLType {
        if (!type) return idl.IDLVoidType
        if (arkts.isTSAnyKeyword(type))
            return idl.IDLAnyType
        if (arkts.isTSThisType(type))
            return idl.IDLThisType
        if (arkts.isTSObjectKeyword(type))
            return idl.IDLObjectType
        if (arkts.isETSUndefinedType(type))
            return idl.IDLUndefinedType
        if (arkts.isETSStringLiteralType(type))
            return idl.IDLStringType
        if (arkts.isTSStringKeyword(type))
            return idl.IDLStringType
        if (arkts.isETSNullType(type))
            return idl.IDLUndefinedType
        if (arkts.isTSArrayType(type))
            return idl.createContainerType('sequence', [this.serializeType((type as arkts.TSArrayType).elementType)])
        if (arkts.isETSUnionType(type))
            return collapseTypes((type as arkts.ETSUnionType).types.map((it) => this.serializeType(it)))
        if (arkts.isETSPrimitiveType(type))
            return this.serializePrimitive((type as arkts.ETSPrimitiveType).primitiveType)
        if (arkts.isETSTypeReference(type)) {
            let name = type.baseName!.name
            if (type.part && arkts.isTSQualifiedName(type.part.name)) {
                const names: string[] = []
                let current: arkts.Expression = type.part.name
                while (current && arkts.isTSQualifiedName(current)) {
                    names.unshift(current.right!.name)
                    current = current.left ?? throwException("!!!")
                }
                names.unshift(name)
                name = names.join('.')
            }
            if (this.isTypeParameter(name)) {
                this.typeParameterFound(name)
                return idl.createTypeParameterReference(name)
            }
            const mbEtsCallback = this.maybeSerializeETSFunctionReference(type)
            if (mbEtsCallback) {
                const [etsCallback, args] = mbEtsCallback
                this.addSyntheticType(etsCallback)
                return idl.createReferenceType(
                    etsCallback.name,
                    args.length === 0 ? undefined : args.map(it => {
                        this.typeParameterFound(it)
                        return idl.createTypeParameterReference(it)
                    })
                )
            }
            const typeArgs = type.part?.typeParams?.params.map(it => this.serializeType(it))
            // special cases //
            switch (name) {
                case 'string': return idl.IDLStringType
                case 'Promise': return idl.createContainerType('Promise', typeArgs ?? [] /* better check here? */)
                case 'Record': return idl.createContainerType('record', typeArgs ?? [] /* better check here? */)
                case 'Map': return idl.createContainerType('record', typeArgs ?? [] /* better check here? */)
                case 'Array': return idl.createContainerType('sequence', typeArgs ?? [] /* better check here? */)
                case 'Date': return idl.IDLDate
                case 'date': return idl.IDLDate
                case 'Object': return idl.IDLObjectType
                case 'object': return idl.IDLObjectType
                case 'ArrayBuffer': return idl.IDLBufferType
                case 'Uint8Array': return idl.IDLBufferType
                case 'Uint8ClampedArray': return idl.IDLBufferType
                case 'Boolean': return idl.IDLBooleanType
                case 'Int32Array': return idl.createContainerType('sequence', [idl.IDLI32Type])
                case 'IterableIterator': return idl.createContainerType('sequence', typeArgs ?? [] /* better check here? */)
                case 'ReadonlyArray': return idl.createContainerType('sequence', typeArgs ?? [] /* better check here? */)
                case 'number': return idl.IDLNumberType
                case 'ErrorCallback': return idl.createReferenceType(name)
                case 'Readonly': return typeArgs![0]
            }
            return idl.createReferenceType(name, typeArgs)
        }
        if (arkts.isETSFunctionType(type)) {
            const [funcType, typeArguments] = this.serializeFunctionType(type as arkts.ETSFunctionType)
            this.addSyntheticType(funcType)
            return idl.createReferenceType(
                funcType.name,
                typeArguments.length === 0 ? undefined : typeArguments.map(arg => {
                    this.typeParameterFound(arg)
                    return idl.createTypeParameterReference(arg)
                })
            )
        }
        if (arkts.isETSTuple(type)) {
            const [tupleType, typeArguments] = this.serializeTupleType(type)
            this.addSyntheticType(tupleType)
            return idl.createReferenceType(
                tupleType.name,
                typeArguments.length === 0 ? undefined : typeArguments.map(arg => {
                    this.typeParameterFound(arg)
                    return idl.createTypeParameterReference(arg)
                })
            )
        }
        throw new Error(`Failed type conversion for ${type ? this.printNode(type) : "undefined"}`)
    }

    serializePrimitive(type: arkts.Es2pandaPrimitiveType): idl.IDLType {
        switch (type) {
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_BYTE: return idl.IDLI8Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_INT: return idl.IDLI32Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_LONG: return idl.IDLI64Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_SHORT: return idl.IDLI16Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_FLOAT: return idl.IDLF32Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_DOUBLE: return idl.IDLF64Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_BOOLEAN: return idl.IDLBooleanType
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_CHAR: return idl.IDLU16Type
            case arkts.Es2pandaPrimitiveType.PRIMITIVE_TYPE_VOID: return idl.IDLVoidType
            default: throw new Error(`Unknown primitive type ${type}`)
        }
    }

    serializeFunctionType(type: arkts.ETSFunctionType): [idl.IDLCallback, string[]] {

        const [[parameters, returnType], typeParams] = this.useTypeParametersTrap(() => {
            const parameters = type.params.map(it => {
                let param = it as arkts.ETSParameterExpression
                return idl.createParameter(param.name, this.serializeType(param.typeAnnotation!), param.isOptional, param.isRestParameter)
            })
            const returnType = this.serializeType(type.returnType)
            return [parameters, returnType] as const
        })
        const orderedTypeParameters = Array.from(typeParams)
        const result = idl.createCallback(
            generateSyntheticFunctionName(parameters, returnType, arkts.hasModifierFlag(type, arkts.Es2pandaModifierFlags.MODIFIER_FLAGS_ASYNC)),
            parameters,
            returnType,
            { fileName: this.fileName },
            orderedTypeParameters.length ? orderedTypeParameters : undefined
        )
        result.extendedAttributes ??= []
        result.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Synthetic })

        return [result, orderedTypeParameters]
    }

    serializeTupleType(type: arkts.ETSTuple): [idl.IDLInterface, string[]] {
        const [properties, typeParameters] = this.useTypeParametersTrap(() => {
            return type.tupleTypeAnnotationsList.map(it => {
                return this.serializeType(it)
            })
        })
        const orderedTypeParameters = Array.from(typeParameters)
        const result = idl.createInterface(
            'Tuple_' + properties.map(it => generateSyntheticIdlNodeName(it)).join('_'),
            idl.IDLInterfaceSubkind.Tuple,
            [], [], [],
            properties.map((it, idx) => {
                return idl.createProperty(`value${idx}`, it)
            })
            , [], [],
            orderedTypeParameters.length ? orderedTypeParameters : undefined,
            {
                fileName: this.fileName,
                extendedAttributes: [
                    { name: idl.IDLExtendedAttributes.Synthetic },
                    { name: idl.IDLExtendedAttributes.Entity, value: idl.IDLEntity.Tuple }
                ]
            }
        )
        return [result, orderedTypeParameters]
    }

    private shouldNotProcessMember(scopeName:string, entryName:string): boolean {
        return this.config.DeletedMethods.get(scopeName)?.includes(entryName) ?? false
    }

    addSyntheticType(entry: idl.IDLEntry) {
        if (this.syntheticEntries.some(it => it.syntheticEntry.name === entry.name)) return
        const currentPovClause = this.packageClause.concat(...this.namespacesPath)
        this.syntheticEntries.push({syntheticEntry: entry, povClause: currentPovClause})
        this.entries.push(entry)
    }

    extractTypeParameters(node: arkts.TSTypeParameterDeclaration | undefined): ExtractTypeParameterInfo {
        const result: string[] = []
        node?.params.forEach(param => {
            if (param.name) {
                // constraint and default value lost here
                result.push(param.name?.name)
            }
        })
        if (result.length === 0) {
            return {
                parameters: undefined,
                set: new Set(),
                attrs: []
            }
        }
        return {
            set: new Set(result),
            attrs: [{ name: idl.IDLExtendedAttributes.TypeParameters, value: result.join(',') }],
            parameters: result
        }
    }

    withTypeParamContext<T>(params: Set<string>, op: () => T): T {
        this.typeParamsStack.push(params)
        const r = op()
        this.typeParamsStack.pop()
        return r
    }
    isTypeParameter(name: string) {
        return this.typeParamsStack.find(bucket => bucket.has(name)) !== undefined
    }

    private typeParamsTraps: Set<string>[] = [new Set()]
    useTypeParametersTrap<R>(op: () => R): [R, Set<string>] {
        this.typeParamsTraps.push(new Set())
        const r = op()
        const record = this.typeParamsTraps.pop()!
        return [r, record]
    }
    typeParameterFound(name: string) {
        this.typeParamsTraps.at(-1)?.add(name)
    }

    markDefaultExport() {
        if (this.defaultExportName) {
            this.entries.forEach(entry => {
                if (entry.name === this.defaultExportName) {
                    entry.extendedAttributes ??= []
                    entry.extendedAttributes.push({
                        name: idl.IDLExtendedAttributes.DefaultExport
                    })
                }
            })
        }
    }

    postprocessEntires(): void {
        /* arkgen specialization */
        if (this.mode === 'arkoala') {
            /* arkgen specialization */
            const componentInterface = this.entries.find(it => idl.hasExtAttribute(it, idl.IDLExtendedAttributes.ComponentInterface))
            if (componentInterface) {
                if (!idl.isInterface(componentInterface)) {
                    throw new Error("ComponentInterface must be interface!")
                }
                const componentUIAttributeRef = componentInterface.callables.at(0)?.returnType
                if (!componentUIAttributeRef || !idl.isReferenceType(componentUIAttributeRef)) {
                    throw new Error("No component attribute found!")
                }
                if (!componentUIAttributeRef.name.startsWith("UI")) {
                    throw new Error("Expecting component attribute to be started with UI like UICommonMethod. If it is not match this criteria, please ensure SDK is correct")
                }
                const componentUIAttributeName = componentUIAttributeRef.name
                const componentAttributeName = componentUIAttributeRef.name.slice(2)
                if (componentUIAttributeRef.name.startsWith("UI")) {
                    componentInterface.callables.forEach(it => it.returnType = idl.createReferenceType(
                        componentAttributeName,
                        componentUIAttributeRef.typeArguments,
                        {
                            documentation: componentUIAttributeRef.documentation,
                            extendedAttributes: componentUIAttributeRef.extendedAttributes,
                            fileName: componentUIAttributeRef.fileName
                        }
                    ))
                }
                const processedEntries: idl.IDLEntry[] = []
                this.entries.forEach(entry => {
                    if (entry.name === componentInterface.name && entry !== componentInterface) {
                        return
                    }
                    if (entry.name === componentUIAttributeName) {
                        return
                    }
                    if (entry.name === componentAttributeName) {
                        entry.extendedAttributes ??= []
                        entry.extendedAttributes.push({ name: idl.IDLExtendedAttributes.Component })
                    }
                    if (idl.isCallback((entry))) {
                        let hasComponentInReferences = false
                        idl.forEachChild(entry, (node) => {
                            if (idl.isNamedNode(node) && [componentUIAttributeName, componentAttributeName].includes(node.name))
                                hasComponentInReferences = true
                        })
                        if (hasComponentInReferences) {
                            return
                        }
                    }
                    processedEntries.push(entry)
                })
                this.entries = processedEntries
            }
        }

        // /* remove synthetic duplicates */
        // function removeDuplicatedByScope(entries:idl.IDLEntry[]): idl.IDLEntry[] {
        //     const namesCount = new Map<string, number>()
        //     const result:idl.IDLEntry[] = []
        //     entries.forEach(entry => {
        //         namesCount.set(entry.name, (namesCount.get(entry.name) ?? 0) + 1)
        //     })
        //     entries.forEach(entry => {
        //         if (idl.isNamespace(entry)) {
        //             entry.members = removeDuplicatedByScope(entry.members)
        //         }
        //         const count = namesCount.get(entry.name)!
        //         if (count > 1) {
        //             if (idl.hasExtAttribute(entry, idl.IDLExtendedAttributes.Synthetic)) {
        //                 result.push(entry)
        //             }
        //         } else {
        //             result.push(entry)
        //         }
        //     })
        //     return result
        // }
        // this.entries = removeDuplicatedByScope(this.entries)
        const syntheticImports: idl.IDLEntry[] = this.syntheticEntries.map(it =>
            idl.createImport([...this.config.SyntheticPackage, it.syntheticEntry.name], it.syntheticEntry.name)
        )
        this.entries = syntheticImports.concat(this.entries)
    }

    toIDLFile(): IDLFile {
        this.markDefaultExport()
        this.postprocessEntires()
        return idl.linkParentBack(idl.createFile(this.entries, this.fileName, this.packageClause))
    }

    toIDLSuperFile(): IDLSuperFile {
        return {
            originalFileName: this.originalFileName,
            writeFilePath: this.fileName,
            skipped: false,
            file: this.toIDLFile(),
            syntheticEntries: this.syntheticEntries,
            exports: this.fileReExports,
        }
    }
}

