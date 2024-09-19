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

import * as ts from 'typescript'
import { SkoalaFile, SkoalaLibrary } from "./SkoalaLibrary";
import { GenericVisitor } from '../options';
import { asString, capitalize, getDeclarationsByNode, identName, isDefined, Language, nameOrNull, stringOrNone } from '../util';
import { WrapperClass, WrapperField, WrapperMethod } from './WrapperClass';
import { ImportExport } from './ImportExport';
import { TSTypeNodeNameConvertor, TypeNodeNameConvertor } from '../peer-generation/TypeNodeNameConvertor';
import { Field, FieldModifier, Method, MethodModifier, NamedMethodSignature, Type } from '../peer-generation/LanguageWriters';
import { Skoala } from './utils';
import { ArgConvertor, RetConvertor } from '../peer-generation/Convertors';
import { TypeProcessor } from '../Library';
import { RuntimeType } from '../peer-generation/PeerGeneratorVisitor';
import { SkoalaTypeProcessor } from './SkoalaDeclarationTable';
import { DeclarationDependenciesCollector, TypeDependenciesCollector } from '../peer-generation/dependencies_collector';
import { convertDeclaration, convertTypeNode } from '../peer-generation/TypeNodeConvertor';

export type SkoalaGeneratorVisitorOptions = {
    sourceFile: ts.SourceFile
    typeChecker: ts.TypeChecker
    skoalaLibrary: SkoalaLibrary
}

export class SkoalaVisitor implements GenericVisitor<void> {
    private readonly sourceFile: ts.SourceFile
    readonly skoalaLibrary: SkoalaLibrary
    readonly currentFile: SkoalaFile

    constructor(options: SkoalaGeneratorVisitorOptions) {
        this.sourceFile = options.sourceFile
        this.skoalaLibrary = options.skoalaLibrary
        this.currentFile = new SkoalaFile(this.sourceFile)
        this.skoalaLibrary.files.push(this.currentFile)
    }

    visitWholeFile(): void {
        ts.forEachChild(this.sourceFile, (node) => this.visit(node))
    }

    visit(node: ts.Node) {
        if (ts.isVariableStatement(node)) {
            this.currentFile.variables.push(node)
        } else if (ts.isModuleDeclaration(node)) {
            if (node.body && ts.isModuleBlock(node.body)) {
                node.body.statements.forEach(it => this.visit(it))
            }
        } else if (ts.isImportEqualsDeclaration(node)) {
            console.log('todo', ts.SyntaxKind[node.kind])
        } else if (ts.isImportSpecifier(node)) {
            console.log('todo', ts.SyntaxKind[node.kind])
        } else if (ts.isImportDeclaration(node)) {
            console.log('todo', ts.SyntaxKind[node.kind])
            this.currentFile.draftImports.add(node)
            // node.importClause.namedBindings.elements[] => ts.ImportSpecifier[]
            // node.parent => sourceFile with classifiableNames
        } else if (ts.isClassDeclaration(node) ||
            ts.isInterfaceDeclaration(node)) {
                this.currentFile.declarations.add(node)
        } else if (ts.isExportDeclaration(node)) {
            console.log('todo', ts.SyntaxKind[node.kind])
        } else if (ts.isEnumDeclaration(node) ||
            ts.isTypeAliasDeclaration(node) ||
            ts.isFunctionDeclaration(node)) {
            this.currentFile.declarations.add(node)
        } else if (
            ts.isEmptyStatement(node) ||
            node.kind == ts.SyntaxKind.EndOfFileToken) {
            // Do nothing.
        } else {
            throw new Error(`Unknown node: ${node.kind} ${asString(node)}`)
        }
    }
}

export class WrapperProcessor {
    readonly importExport: ImportExport
    readonly typeNodeConvertor: TypeNodeNameConvertor
    private readonly typeDependenciesCollector: TypeDependenciesCollector
    private readonly declDependenciesCollector: DeclarationDependenciesCollector

    constructor(readonly typeChecker: ts.TypeChecker) {
        this.importExport = new ImportExport(typeChecker)
        this.typeNodeConvertor = new TSTypeNodeNameConvertor()
        this.typeDependenciesCollector = new TypeDependenciesCollector(typeChecker, Language.TS)
        this.declDependenciesCollector = new DeclarationDependenciesCollector(typeChecker, this.typeDependenciesCollector)
    }

    isWrapper(node: ts.InterfaceDeclaration | ts.ClassDeclaration): boolean {
        return !!this.findHeritageClasses(node)
    }

    process(library: SkoalaLibrary) {
        for (let file of library.files) {
            for (let importDecl of file.draftImports) {
                let namedImportBindings = importDecl.importClause?.namedBindings
                let module = importDecl.moduleSpecifier
                if (namedImportBindings && ts.isNamedImports(namedImportBindings) && ts.isStringLiteral(module)) {
                    let features = namedImportBindings.elements.map(importSpec => importSpec.getText())
                    file.addImportFeature(module.text, features)
                    // namedImportBindings.elements.forEach(importSpec => {
                    //     let realDeclaration = this.importExport.findRealDeclaration(importSpec.name)                        
                    // })
                } else if (namedImportBindings && ts.isNamespaceImport(namedImportBindings)) {
                    // todo
                } else {
                    // todo
                }
            }

            for (let decl of file.declarations) {
                let dependencies = this.declDependenciesCollector.convert(decl)
                    .map(it => {
                        if (ts.isImportSpecifier(it)) {
                            return this.importExport.findRealDeclaration(it.name)
                        } else return it
                    })
                    .filter(it => isSourceDecl(it))

                dependencies.forEach(it => {
                    if (it && (ts.isClassDeclaration(it) || ts.isClassDeclaration(it))) {
                        library.serializerDeclarations.add(it)
                    }
                })

                if (ts.isClassDeclaration(decl) || ts.isInterfaceDeclaration(decl)) {
                    let wrapperClass = this.tryProcessWrapper(decl, file)
                    if (wrapperClass) {
                        file.declarations.delete(decl)
                        file.wrapperClasses.set(wrapperClass.className, wrapperClass)
                    } else {
                        library.serializerDeclarations.add(decl)
                    }
                }
            }
        }
    }

    private tryProcessWrapper(node: ts.InterfaceDeclaration | ts.ClassDeclaration, file: SkoalaFile): WrapperClass | undefined {
        let heritageClasses = this.findHeritageClasses(node)
        if (!heritageClasses?.length) return undefined

        let name = nameOrNull(node.name)!
        let baseClass = heritageClasses[heritageClasses.length - 1]
        if (!(baseClass in Skoala.BaseClasses)) {
            console.log(`incorrect class heritage: ${baseClass}, (${heritageClasses.join(',')})`);
            throw Error()
        }
        let constructor = ts.isClassDeclaration(node) ? node.members.find(ts.isConstructorDeclaration) : undefined
        let wConstructor = constructor ? this.makeWrapperMethod(name, constructor, this.typeNodeConvertor) : undefined
        let finalizer = ts.isClassDeclaration(node)
            ? node.members.filter(ts.isMethodDeclaration).find(it => it.name.getText() == Skoala.getFinalizer)
            : node.members.filter(ts.isMethodSignature).find(it => it.name.getText() == Skoala.getFinalizer)
        let wFinalizer = finalizer ? this.makeWrapperMethod(name, finalizer, this.typeNodeConvertor) : undefined

        let wFields = ts.isInterfaceDeclaration(node)
            ? node.members
                .filter(ts.isPropertySignature)
                .map(it => this.makeWrapperField(name, it))
            : node.members
                .filter(ts.isPropertyDeclaration)
                .map(it => this.makeWrapperField(name, it))

        let wMethods = ts.isInterfaceDeclaration(node)
            ? node.members
                .filter(ts.isMethodSignature).filter(it => it.name.getText() != Skoala.getFinalizer)
                .map(method => this.makeWrapperMethod(name, method, this.typeNodeConvertor))
            : node.members
                .filter(ts.isMethodDeclaration).filter(it => it.name.getText() != Skoala.getFinalizer)
                .map(method => this.makeWrapperMethod(name, method, this.typeNodeConvertor))
        
        wFields.forEach(f => {
            const field = f.field
            // TBD: use deserializer to get complex type from native
            const isSimpleType = f.argConvertor ? !f.argConvertor.useArray : true // type needs to be deserialized from the native
            if (isSimpleType) {
                const getAccessor = new WrapperMethod(name, 
                    new Method(`get${capitalize(field.name)}`, new NamedMethodSignature(field.type, [], []), [MethodModifier.PRIVATE]),
                    [], f.retConvertor
                )
                wMethods.push(getAccessor)
            }

            const isReadOnly = field.modifiers.includes(FieldModifier.READONLY)
            if (!isReadOnly) {
                const setSignature = new NamedMethodSignature(Type.Void, [field.type], [field.name])
                const retConvertor = { isVoid: true, nativeType: () => Type.Void.name, macroSuffixPart: () => "" }
                const setAccessor = new WrapperMethod(name,
                    new Method(`set${capitalize(field.name)}`, setSignature, [MethodModifier.PRIVATE]), 
                    f.argConvertor ? [f.argConvertor] : [], retConvertor,
                )
                wMethods.push(setAccessor)
            }
        })
        
        this.collectRequiredImports(wMethods, file)

        return new WrapperClass(
            name,
            ts.isInterfaceDeclaration(node),
            baseClass as Skoala.BaseClasses,
            heritageClasses,
            wFields,
            wConstructor,
            wFinalizer,
            wMethods
        )
    }

    private makeWrapperField(className: string,
        property: ts.PropertyDeclaration | ts.PropertySignature
    ): WrapperField {
        let modifiers: FieldModifier[] = []
        property.modifiers?.forEach(modifier => {
            if (modifier.kind == ts.SyntaxKind.PublicKeyword) {
                modifiers.push(FieldModifier.PUBLIC)
            }
            if (modifier.kind == ts.SyntaxKind.PrivateKeyword) {
                modifiers.push(FieldModifier.PRIVATE)
            }
            if (modifier.kind == ts.SyntaxKind.StaticKeyword) {
                modifiers.push(FieldModifier.STATIC)
            }
            if (modifier.kind == ts.SyntaxKind.ReadonlyKeyword) {
                modifiers.push(FieldModifier.READONLY)
            }
        })
        // TODO: add convertor to convers property.type, property.name
        // TODO: add arg and ret convertors
        return new WrapperField(
            new Field(property.name.getText(), new Type(property.type?.getText() ?? ""), modifiers),
            undefined,
            undefined,
        )
    }

    private makeWrapperMethod(parentName: string,
        tsMethod: ts.ConstructorDeclaration | ts.MethodDeclaration | ts.MethodSignature,
        typeNodeConverter: TypeNodeNameConvertor
    ): WrapperMethod {
        // TODO: add convertor to convers method.type, method.name, method.parameters[..].type, method.parameters[..].name
        // TODO: add arg and ret convertors
        let args: Type[] = []
        let argsNames: string[] = []
        let defaults: stringOrNone[] = []
        let typeProcessor = new SkoalaTypeProcessor()
        typeProcessor.typeChecker = this.importExport.typeChecker
        let argConvertors = tsMethod.parameters.map(param => {
            defaults.push(param.initializer?.getText())
            args.push(new Type(param.type?.getText() ?? "", !!param.questionToken))
            argsNames.push(param.name.getText())
            return generateArgConvertor(typeProcessor, param, typeNodeConverter)
        })

        let retConvertor = generateRetConvertor()

        let modifiers: MethodModifier[] = []
        tsMethod.modifiers?.forEach(modifier => {
            if (modifier.kind == ts.SyntaxKind.PublicKeyword) {
                modifiers.push(MethodModifier.PUBLIC)
            }
            if (modifier.kind == ts.SyntaxKind.PrivateKeyword) {
                modifiers.push(MethodModifier.PRIVATE)
            }
            if (modifier.kind == ts.SyntaxKind.StaticKeyword) {
                modifiers.push(MethodModifier.STATIC)
            }
        })

        let method: Method
        if (ts.isConstructorDeclaration(tsMethod)) {
            method = new Method("constructor", new NamedMethodSignature(Type.Void, args, argsNames, defaults), modifiers)
        } else {
            if (ts.isGetAccessor(tsMethod)) modifiers.push(MethodModifier.GETTER)
            if (ts.isSetAccessor(tsMethod)) {
                modifiers.push(MethodModifier.SETTER)
            }
            method = new Method(tsMethod.name.getText(), new NamedMethodSignature(new Type(tsMethod.type?.getText() ?? ""), args, argsNames, defaults), modifiers)
        }

        return new WrapperMethod(parentName, method, argConvertors, retConvertor)
    }

    private collectRequiredImports(methods: WrapperMethod[], file: SkoalaFile) {
        methods.forEach(it => {
            if (it.isMakeMethod()) {
                file.addImportFeature("@koalaui/interop", ["isNullPtr"])
            }
            it.argConvertors.forEach(conv => {
                if (conv.runtimeTypes.length > 1 || conv.runtimeTypes.indexOf(RuntimeType.OBJECT) > -1
                    || conv.runtimeTypes.indexOf(RuntimeType.MATERIALIZED) > -1
                    || conv.runtimeTypes.indexOf(RuntimeType.FUNCTION) > -1
                ) {
                    file.addImportFeature("./Serializer", ["createSerializer", "Serializer"])
                    file.addImportFeature("./SerializerBase", ["RuntimeType", "runtimeType", "SerializerBase"])
                    file.addImportFeature("./utils", ["unsafeCast"])
                }
            })
        })
        file.addImportFeature(Skoala.NativeModuleImportFeature.module, Skoala.NativeModuleImportFeature.features)
    }

    private findHeritageClasses(declaration: ts.InterfaceDeclaration | ts.ClassDeclaration, heritageClasses: string[] = []): string[] | undefined {
        const superClassType = declaration.heritageClauses
            ?.filter(it => it.token == ts.SyntaxKind.ExtendsKeyword)[0]?.types[0]

        if (superClassType) {
            const superClassName = identName(superClassType.expression)!
            heritageClasses.push(superClassName)
            if (superClassName in Skoala.BaseClasses) {
                return heritageClasses
            }

            let superClass = superClassType.expression
            let superClassDeclaration = getDeclarationsByNode(this.importExport.typeChecker, superClass)?.[0]
            if (superClassDeclaration) {
                if (ts.isImportSpecifier(superClassDeclaration)) {
                    let realSuperClassDeclaration = this.importExport.findRealDeclaration(superClassDeclaration.name)
                    if (realSuperClassDeclaration && (ts.isClassDeclaration(realSuperClassDeclaration) || ts.isInterfaceDeclaration(realSuperClassDeclaration))) {
                        return this.findHeritageClasses(realSuperClassDeclaration, heritageClasses)
                    }
                } else if (ts.isClassDeclaration(superClassDeclaration) || ts.isInterfaceDeclaration(superClassDeclaration)) {
                    return this.findHeritageClasses(superClassDeclaration, heritageClasses)
                }
            }
        }

        return undefined
    }
}

function generateArgConvertor(typeProcessor: TypeProcessor,
    param: ts.ParameterDeclaration,
    typeNodeNameConvertor: TypeNodeNameConvertor): ArgConvertor {
    if (!param.type) throw new Error("Type is needed")
    let paramName = asString(param.name)
    let optional = param.questionToken !== undefined
    return typeProcessor.typeConvertor(paramName, param.type, optional, typeNodeNameConvertor)
}

function generateRetConvertor(): RetConvertor {
    // todo
    return {
        isVoid: false, 
        macroSuffixPart: () => "",
        nativeType: () => "",
    }
}

function isSourceDecl(node: ts.Declaration | undefined): boolean {
    if (!node) return false
    if (ts.isModuleBlock(node.parent))
        return isSourceDecl(node.parent.parent)
    if (ts.isTypeParameterDeclaration(node))
        return false
    if (!ts.isSourceFile(node.parent))
        throw 'Expected declaration to be at file root'
    return !node.parent.fileName.endsWith('stdlib.d.ts')
}