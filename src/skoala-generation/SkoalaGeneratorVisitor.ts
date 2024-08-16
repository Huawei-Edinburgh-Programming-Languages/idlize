import * as ts from 'typescript'
import * as path from 'path'
import { GenericVisitor } from "../options"
import { ComponentDeclaration, ComponentsCompleter, createInterfaceDeclName, createTypeDependenciesCollector, createTypeNodeConvertor, FilteredDeclarationCollector, generateArgConvertor, generateMethodModifiers, generateRetConvertor, generateSignature, getMethodIndex, ImportsAggregateCollector, isSourceDecl, PeerGeneratorVisitor, PeersGenerator } from "../peer-generation/PeerGeneratorVisitor"
import { asString, capitalize, getComment, getDeclarationsByNode, getSymbolByNode, identName, isReadonly, Language, nameOrNull, serializerBaseMethods, throwException } from '../util'
import { PeerGeneratorConfig } from '../peer-generation/PeerGeneratorConfig'
import { checkTSDeclarationMaterialized, isMaterialized, MaterializedClass, MaterializedField, MaterializedMethod, SuperElement } from '../peer-generation/Materialized'
import { EnumEntity, PeerFile } from '../peer-generation/PeerFile'
import { DeclarationTable, PrimitiveType } from '../peer-generation/DeclarationTable'
import { PeerClass } from '../peer-generation/PeerClass'
import { BuilderClass, isBuilderClass, isCustomBuilderClass, toBuilderClass } from '../peer-generation/BuilderClass'
import { PeerLibrary } from "../peer-generation/PeerLibrary"
import { DeclarationDependenciesCollector, TypeDependenciesCollector } from '../peer-generation/dependencies_collector'
import { lazy } from '../peer-generation/lazy'
import { mapType, TypeNodeNameConvertor } from '../peer-generation/TypeNodeNameConvertor'
import { convertDeclToFeature } from '../peer-generation/ImportsCollector'
import { Field, FieldModifier, Method, MethodModifier, NamedMethodSignature, Type } from '../peer-generation/LanguageWriters'
import { isSyntheticDeclaration, makeSyntheticInterfaceDeclaration } from '../peer-generation/synthetic_declaration'
import { convertTypeNode, convertDeclaration } from '../peer-generation/TypeNodeConvertor'
import { Install } from '../Install'
import { TargetFile } from '../peer-generation/printers/TargetFile'
import { OptionValues } from "commander"

/**
 * {@link PeerLibrary}
 */
export class SkoalaDeclLibrary {
    draftDeclarations: ts.Declaration[] = []

    public readonly files: PeerFile[] = []
    public readonly builderClasses: Map<string, BuilderClass> = new Map()
    public get buildersToGenerate(): BuilderClass[] {
        return Array.from(this.builderClasses.values()).filter(it => it.needBeGenerated)
    }

    public readonly materializedClasses: Map<string, MaterializedClass> = new Map()
    public get materializedToGenerate(): MaterializedClass[] {
        return Array.from(this.materializedClasses.values()).filter(it => it.needBeGenerated)
    }

    constructor(
        public declarationTable: DeclarationTable,
        public componentsToGenerate: Set<string>,
    ) { }

    readonly customComponentMethods: string[] = []
    // todo really dirty - we use it until we can generate interfaces
    // replacing import type nodes
    readonly importTypesStubToSource: Map<string, string> = new Map()
    readonly componentsDeclarations: ComponentDeclaration[] = []
    readonly conflictedDeclarations: Set<ts.Declaration> = new Set()

    findPeerByComponentName(componentName: string): PeerClass | undefined {
        for (const file of this.files)
            for (const peer of file.peers.values())
                if (peer.componentName == componentName)
                    return peer
        return undefined
    }

    findFileByOriginalFilename(filename: string): PeerFile | undefined {
        return this.files.find(it => it.originalFilename === filename)
    }

    findComponentByDeclaration(node: ts.Declaration): ComponentDeclaration | undefined {
        return this.componentsDeclarations.find(it => {
            return it.interfaceDeclaration === node || it.attributesDeclarations === node
        })
    }

    isComponentDeclaration(node: ts.Declaration): boolean {
        return this.findComponentByDeclaration(node) !== undefined
    }

    shouldGenerateComponent(name: string): boolean {
        return !this.componentsToGenerate.size || this.componentsToGenerate.has(name)
    }
}

export type SkoalaGeneratorVisitorOptions = {
    sourceFile: ts.SourceFile
    typeChecker: ts.TypeChecker
    declarationTable: DeclarationTable,
    skoaladeclLibrary: SkoalaDeclLibrary
}

/**
 * {@link PeerGeneratorVisitor}
 */
export class SkoalaGeneratorVisitor implements GenericVisitor<void> {
    private readonly sourceFile: ts.SourceFile
    declarationTable: DeclarationTable

    static readonly serializerBaseMethods = serializerBaseMethods()
    readonly typeChecker: ts.TypeChecker

    readonly skoalaLibrary: SkoalaDeclLibrary
    readonly peerFile: PeerFile

    constructor(options: SkoalaGeneratorVisitorOptions) {
        this.sourceFile = options.sourceFile
        this.typeChecker = options.typeChecker
        this.declarationTable = options.declarationTable
        this.skoalaLibrary = options.skoaladeclLibrary
        this.peerFile = new PeerFile(this.sourceFile.fileName, this.declarationTable, this.skoalaLibrary.componentsToGenerate)
        this.skoalaLibrary.files.push(this.peerFile)
    }

    visitWholeFile(): void {
        ts.forEachChild(this.sourceFile, (node) => this.visit(node))
    }

    visit(node: ts.Node) {
        if (ts.isVariableStatement(node)) {
            console.log('VariableStatement')
            this.processVariableStatement(node)
        } else if (ts.isModuleDeclaration(node)) {
            if (node.body && ts.isModuleBlock(node.body)) {
                node.body.statements.forEach(it => this.visit(it))
            }
        } else if (
            ts.isImportSpecifier(node) ||
            ts.isImportEqualsDeclaration(node)
        ) {
            // TODO:
            console.log('import')
        } else if (ts.isImportDeclaration(node)) {
            console.log('import declaration')
            //node.parent => sourceFile with classifiableNames
        } else if (ts.isClassDeclaration(node) ||
            ts.isInterfaceDeclaration(node) ||
            ts.isEnumDeclaration(node) ||
            ts.isExportDeclaration(node) ||
            ts.isTypeAliasDeclaration(node) ||
            ts.isFunctionDeclaration(node) ||
            ts.isExportDeclaration(node)) {
            this.skoalaLibrary.draftDeclarations.push(node)
        } else if (
            ts.isEmptyStatement(node) ||
            node.kind == ts.SyntaxKind.EndOfFileToken) {
            console.log('EmptyStatement')
            // Do nothing.
        } else {
            throw new Error(`Unknown node: ${node.kind} ${node.getText()}`)
        }
    }

    private processVariableStatement(node: ts.VariableStatement) {
        node.declarationList.declarations.forEach(variable => {
            const interfaceDecl = this.maybeTypeReferenceToDeclaration(variable.type)
            if (!interfaceDecl || !ts.isInterfaceDeclaration(interfaceDecl))
                return
            const attributesDecl = this.interfaceToComponentAttributes(interfaceDecl)
            if (attributesDecl) {
                if (this.skoalaLibrary.isComponentDeclaration(interfaceDecl) ||
                    this.skoalaLibrary.isComponentDeclaration(attributesDecl))
                    throw new Error("Component is already defined")
                const componentName = identName(variable.name)!
                if (PeerGeneratorConfig.ignoreComponents.includes(componentName))
                    return
                this.skoalaLibrary.componentsDeclarations.push(new ComponentDeclaration(
                    componentName,
                    interfaceDecl,
                    attributesDecl,
                ))
            }
        })
    }

    private maybeTypeReferenceToDeclaration(node: ts.TypeNode | undefined): ts.Declaration | undefined {
        if (!node || !ts.isTypeReferenceNode(node))
            return undefined
        return getDeclarationsByNode(this.typeChecker, node.typeName)?.[0]
    }

    private interfaceToComponentAttributes(node: ts.InterfaceDeclaration | undefined): ts.ClassDeclaration | undefined {
        if (!node)
            return undefined
        const members = node.members.filter(it => !ts.isConstructSignatureDeclaration(it))
        if (!members.length || !members.every(it => ts.isCallSignatureDeclaration(it)))
            return undefined
        const callable = members[0] as ts.CallSignatureDeclaration
        const retDecl = this.maybeTypeReferenceToDeclaration(callable.type)
        const isSameReturnType = (node: ts.TypeElement): boolean => {
            if (!ts.isCallSignatureDeclaration(node))
                throw "Expected to be a call signature"
            const otherRetDecl = this.maybeTypeReferenceToDeclaration(node.type)
            return otherRetDecl === retDecl
        }

        if (!retDecl || !ts.isClassDeclaration(retDecl) || !members.every(isSameReturnType))
            return undefined

        return retDecl
    }
}

export class LocalPeerProcessor {
    private readonly typeDependenciesCollector: TypeDependenciesCollector
    private readonly declDependenciesCollector: DeclarationDependenciesCollector
    private readonly serializeDepsCollector: DeclarationDependenciesCollector

    constructor(
        private readonly library: SkoalaDeclLibrary,
    ) {
        this.typeDependenciesCollector = createTypeDependenciesCollector(this.library, {
            declDependenciesCollector: lazy(() => this.declDependenciesCollector)
        })
        this.declDependenciesCollector = new FilteredDeclarationCollector(this.library, this.typeDependenciesCollector)
        this.serializeDepsCollector = new FilteredDeclarationCollector(
            this.library, new ImportsAggregateCollector(this.library, true))
    }
    private get declarationTable(): DeclarationTable {
        return this.library.declarationTable
    }

    private processMaterialized(target: ts.InterfaceDeclaration | ts.ClassDeclaration,
        isActualDeclaration: boolean,
        typeNodeConvertor: TypeNodeNameConvertor) {
        let name = nameOrNull(target.name)!
        if (this.library.materializedClasses.has(name)) {
            return
        }

        const isClass = ts.isClassDeclaration(target)
        const isInterface = ts.isInterfaceDeclaration(target)

        const superClassType = target.heritageClauses
            ?.filter(it => it.token == ts.SyntaxKind.ExtendsKeyword)[0]?.types[0]

        const superClass = superClassType ?
            new SuperElement(
                identName(superClassType.expression)!,
                superClassType.typeArguments?.filter(ts.isTypeReferenceNode).map(it => identName(it.typeName)!))
            : undefined

        const importFeatures = this.serializeDepsCollector.convert(target)
            .filter(it => isSourceDecl(it))
            .filter(it => PeerGeneratorConfig.needInterfaces || checkTSDeclarationMaterialized(it) || isSyntheticDeclaration(it))
            .map(it => convertDeclToFeature(this.library, it))
        const generics = target.typeParameters?.map(it => it.getText())

        let constructor = isClass ? target.members.find(ts.isConstructorDeclaration) : undefined
        typeNodeConvertor = createTypeNodeConvertor(this.library, typeNodeConvertor, this.declDependenciesCollector, importFeatures)
        let mConstructor = this.makeMaterializedMethod(name, constructor, isActualDeclaration, typeNodeConvertor)
        const finalizerReturnType = { isVoid: false, nativeType: () => PrimitiveType.NativePointer.getText(), macroSuffixPart: () => "" }
        let mFinalizer = new MaterializedMethod(name, [], [], finalizerReturnType, false,
            new Method("getFinalizer", new NamedMethodSignature(Type.Pointer, [], [], []), [MethodModifier.STATIC]), 0)
        let mFields = isClass
            ? target.members
                .filter(ts.isPropertyDeclaration)
                .map(it => this.makeMaterializedField(name, it))
            : isInterface
                ? target.members
                    .filter(ts.isPropertySignature)
                    .map(it => this.makeMaterializedField(name, it))
                : []

        let mMethods = isClass
            ? target.members
                .filter(ts.isMethodDeclaration)
                .map(method => this.makeMaterializedMethod(name, method, isActualDeclaration, typeNodeConvertor))
            : isInterface
                ? target.members
                    .filter(ts.isMethodSignature)
                    .map(method => this.makeMaterializedMethod(name, method, isActualDeclaration, typeNodeConvertor))
                : []

        // todo: add getters and setters
        /*
        let mAccessors = target.members
            .filter(ts.isSetAccessor || ts.isGetAccessor || ts.isSetAccessorDeclaration || ts.isGetAccessorDeclaration)
            .map(accessor => this.makeMaterializedAccessor(name, accessor, isActualDeclaration, typeNodeConvertor))
         */

        // TODO: Properly handle methods with return Promise<T> type
        mMethods = mMethods.filter(it => !PeerGeneratorConfig.ignoreReturnTypes.has(
            it.method.signature.returnType.name
        ))

        mFields.forEach(f => {
            const field = f.field
            // TBD: use deserializer to get complex type from native
            const isSimpleType = !f.argConvertor.useArray // type needs to be deserialized from the native
            if (isSimpleType) {
                const getAccessor = new MaterializedMethod(name, [], [], f.retConvertor, false,
                    new Method(`get${capitalize(field.name)}`, new NamedMethodSignature(field.type, [], []), [MethodModifier.PRIVATE]), 0
                )
                mMethods.push(getAccessor)
            }

            const isReadOnly = field.modifiers.includes(FieldModifier.READONLY)
            if (!isReadOnly) {
                const setSignature = new NamedMethodSignature(Type.Void, [field.type], [field.name])
                const retConvertor = { isVoid: true, nativeType: () => Type.Void.name, macroSuffixPart: () => "V" }
                const setAccessor = new MaterializedMethod(name, [f.declarationTarget], [f.argConvertor], retConvertor, false,
                    new Method(`set${capitalize(field.name)}`, setSignature, [MethodModifier.PRIVATE]), 0
                )
                mMethods.push(setAccessor)
            }
        })

        // In ArkTS we need generate a real interface in SyntheticDeclarations
        if (this.library.declarationTable.language == Language.ARKTS && ts.isInterfaceDeclaration(target)) {
            const declName = createInterfaceDeclName(identName(target)!)
            importFeatures.push(convertDeclToFeature(this.library,
                makeSyntheticInterfaceDeclaration('SyntheticDeclarations', declName, target.members, this.declDependenciesCollector!, this.library)))
        }

        this.library.materializedClasses.set(name,
            new MaterializedClass(name, isInterface, superClass, generics, mFields, mConstructor, mFinalizer, importFeatures, mMethods, isActualDeclaration))
    }

    private makeMaterializedField(className: string, property: ts.PropertyDeclaration | ts.PropertySignature): MaterializedField {
        const name = identName(property.name)!
        this.declarationTable.setCurrentContext(`Materialized_${className}_${name}`)
        const declarationTarget = this.declarationTable.toTarget(property.type!)
        const argConvertor = this.declarationTable.typeConvertor(name, property.type!)
        const retConvertor = generateRetConvertor(property.type!)
        const modifiers = isReadonly(property.modifiers) ? [FieldModifier.READONLY] : []
        this.declarationTable.setCurrentContext(undefined)
        return new MaterializedField(declarationTarget, argConvertor, retConvertor,
            new Field(name, new Type(mapType(property.type)), modifiers))
    }

    private makeMaterializedMethod(parentName: string,
        method: ts.ConstructorDeclaration | ts.MethodDeclaration | ts.MethodSignature | undefined,
        isActualDeclaration: boolean,
        typeNodeConverter: TypeNodeNameConvertor) 
    {
        const methodName = method === undefined || ts.isConstructorDeclaration(method) ? "ctor" : identName(method.name)!
        this.declarationTable.setCurrentContext(`Materialized_${parentName}_${methodName}`)

        const retConvertor = method === undefined || ts.isConstructorDeclaration(method)
            ? { isVoid: false, isStruct: false, nativeType: () => PrimitiveType.NativePointer.getText(), macroSuffixPart: () => "" }
            : generateRetConvertor(method.type)

        if (method === undefined) {
            // interface or class without constructors
            const ctor = new Method("ctor", new NamedMethodSignature(Type.Void, [], []), [MethodModifier.STATIC])
            this.declarationTable.setCurrentContext(undefined)
            return new MaterializedMethod(parentName, [], [], retConvertor, false, ctor, 0)
        }

        const generics = method.typeParameters?.map(it => it.getText())
        const argDeclarations = method.parameters.map(param => // todo
            this.declarationTable.toTarget(param.type ??
                throwException(`Expected a type for ${asString(param)} in ${asString(method)}`)))
        method.parameters.forEach(it => this.declarationTable.requestType(undefined, it.type!, isActualDeclaration))
        const argConvertors = method.parameters.map(param => generateArgConvertor(this.declarationTable, param)) // todo
        const signature = generateSignature(method, typeNodeConverter)
        const modifiers = generateMethodModifiers(method)
        this.declarationTable.setCurrentContext(undefined)
        return new MaterializedMethod(parentName, argDeclarations, argConvertors, retConvertor, false,
            new Method(methodName, signature, modifiers, generics), getMethodIndex(methodName, method))
    }

    private processEnum(node: ts.EnumDeclaration) {
        const file = this.getDeclSourceFile(node)
        let name = node.name.getText()
        let comment = getComment(file, node)
        let enumEntity = new EnumEntity(name, comment)
        node.forEachChild(child => {
            if (ts.isEnumMember(child)) {
                let name = child.name.getText()
                let comment = getComment(file, child)
                enumEntity.pushMember(name, comment, child.initializer?.getText())
            }
        })
        this.library.findFileByOriginalFilename(file.fileName)!.pushEnum(enumEntity)
    }

    private getDeclSourceFile(node: ts.Declaration): ts.SourceFile {
        if (ts.isModuleBlock(node.parent))
            return this.getDeclSourceFile(node.parent.parent)
        if (ts.isImportSpecifier(node)) {
            return this.getDeclSourceFile(node.parent.parent)
        }
        if (node.parent && ts.isSourceFile(node.parent)) {
            return node.parent
        }
        if (node.parent.parent && ts.isSourceFile(node.parent.parent)) {
            return node.parent.parent
        }
        // if (!ts.isSourceFile(node.parent))
        throw 'Expected declaration to be at file root'
        // return node.parent
    }

    private collectDepsRecursive(node: ts.Declaration | ts.TypeNode, deps: Set<ts.Declaration>): void {
        const currentDeps = ts.isTypeNode(node)
            ? convertTypeNode(this.typeDependenciesCollector, node)
            : convertDeclaration(this.declDependenciesCollector, node)
        for (const dep of currentDeps) {
            if (deps.has(dep)) continue
            if (!isSourceDecl(dep)) continue
            deps.add(dep)
            this.collectDepsRecursive(dep, deps)
        }
    }
    private generateDeclarations(freeDeclaration: ts.Declaration[]): Set<ts.Declaration> {
        const deps = new Set(freeDeclaration)
        const depsCopy = Array.from(deps)
        for (const dep of depsCopy) {
            this.collectDepsRecursive(dep, deps)
        }
        for (const dep of Array.from(deps)) {
            if (ts.isEnumMember(dep)) { // well.. okay
                deps.add(dep.parent)
                deps.delete(dep)
            }
        }
        return deps
    }

    process(): void { // todo
        new ComponentsCompleter(this.library).process()
        const declarations = this.generateDeclarations(this.library.draftDeclarations)
        const typeNodeConvertor = createTypeNodeConvertor(this.library)

        for (const dep of declarations) {
            if (isSyntheticDeclaration(dep)) {
                continue
            }

            if (ts.isImportDeclaration(dep)) {
                console.log('-');
                // todo
                // OR isImportEqualsDeclaration? / isImportClause / isImportSpecifier ??
            }

            if (ts.isImportEqualsDeclaration(dep)) {
                console.log('-');
            }

            if (ts.isTypeAliasDeclaration(dep)) {
                console.log('-');
                // todo
            }

            if (ts.isFunctionDeclaration(dep)) {
                console.log('-');
                // todo
            }

            if (ts.isClassDeclaration(dep) || ts.isInterfaceDeclaration(dep)) {
                if (isMaterialized(dep)) {
                    this.processMaterialized(dep, true, typeNodeConvertor)
                    continue
                }
            }

            if (ts.isEnumDeclaration(dep)) {
                this.processEnum(dep)
                continue
            }

            // todo: import features !!!
            const file = this.library.findFileByOriginalFilename(this.getDeclSourceFile(dep).fileName)!
            this.declDependenciesCollector.convert(dep).forEach(it => {
                if (isSourceDecl(it) && (PeerGeneratorConfig.needInterfaces || isSyntheticDeclaration(it)))
                    file.importFeatures.push(convertDeclToFeature(this.library, it))
            })
            this.serializeDepsCollector.convert(dep).forEach(it => {
                if (isSourceDecl(it) && PeerGeneratorConfig.needInterfaces) {
                    file.serializeImportFeatures.push(convertDeclToFeature(this.library, it))
                }
            })
            if (PeerGeneratorConfig.needInterfaces) {
                file.declarations.add(dep)
                file.importFeatures.push(convertDeclToFeature(this.library, dep))
            }
        }
    }
}

export class SkoalaInstall extends Install {
    constructor(private outDir: string, private lang: Language, private test: boolean) {
        super()
    }
    langDir(): string {
        switch (this.lang) {
            case Language.TS: return this.tsDir
            case Language.JAVA: return this.javaDir
            case Language.CJ: return this.cjDir
            default: throw new Error("unsupported")
        }
    }
    createDirs(dirs: string[]) {
        for (const dir of dirs) {
            this.mkdir(dir)
        }
    }
    sig = this.mkdir(this.test ? path.join(this.outDir, "sig") : this.outDir)

    tsDir = this.mkdir(path.join(this.sig, "skoala/src/"))

    frameworkDir = this.mkdir(path.join(this.sig, "skoala/framework"))
    tsSkoalaDir = this.mkdir(path.join(this.frameworkDir, "src/generated/"))
    nativeDir = this.mkdir(path.join(this.frameworkDir, "native/src/generated/"))
    javaDir = this.mkdir(path.join(this.frameworkDir, "java/src/"))
    cjDir = this.mkdir(path.join(this.frameworkDir, "cangjie/src/"))
    peer(targetFile: TargetFile): string {
        const peerDir = this.mkdir(path.join(this.langDir(), this.lang === Language.JAVA || this.lang === Language.CJ ? '.' : 'peers'))
        return path.join(peerDir, targetFile.path ?? "", targetFile.name + this.lang.extension)
    }
    component(targetFile: TargetFile): string {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    }
    builderClass(targetFile: TargetFile): string {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    }
    materialized(targetFile: TargetFile): string {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    }
    interface(targetFile: TargetFile): string {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    }
    langLib(targetFile: TargetFile) {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name + this.lang.extension)
    }
    tsLib(targetFile: TargetFile) {
        return path.join(this.tsDir, targetFile.path ?? "", targetFile.name + this.lang.extension)
    }
    tsSkoalaLib(targetFile: TargetFile) {
        return path.join(this.tsSkoalaDir, targetFile.path ?? "", targetFile.name + this.lang.extension)
    }
    javaLib(targetFile: TargetFile) {
        return path.join(this.javaDir, targetFile.path ?? "", targetFile.name + this.lang.extension)
    }
    cjLib(targetFile: TargetFile) {
        return path.join(this.cjDir, targetFile.path ?? "", targetFile.name + this.lang.extension)
    }
    native(targetFile: TargetFile) {
        return path.join(this.nativeDir, targetFile.path ?? "", targetFile.name)
    }
}