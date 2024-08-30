import * as ts from 'typescript'
import { SkoalaFile, SkoalaLibrary } from "./SkoalaLibrary";
import { GenericVisitor } from '../options';
import { getDeclarationsByNode, identName, nameOrNull } from '../util';
import { WrapperClass, WrapperField, WrapperMethod } from './WrapperClass';
import { ImportExport } from './ImportExport';
import { TypeNodeConvertor } from '../peer-generation/TypeNodeConvertor';
import { TSTypeNodeNameConvertor, TypeNodeNameConvertor } from '../peer-generation/TypeNodeNameConvertor';
import { Method, NamedMethodSignature, Type } from '../peer-generation/LanguageWriters';

export type SkoalaGeneratorVisitorOptions = {
    sourceFile: ts.SourceFile
    typeChecker: ts.TypeChecker
    skoalaLibrary: SkoalaLibrary
}

export class SkoalaVisitor implements GenericVisitor<void> {
    private readonly sourceFile: ts.SourceFile
    // declarationTable: DeclarationTable

    // static readonly serializerBaseMethods = serializerBaseMethods()

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
                // if (this.wrapperProcessor.isWrapper(node)) {
                //     this.skoalaLibrary.draftWrapperClasses.set(nameOrNull(node.name)!, node)
                // } else {
                    this.currentFile.declarations.add(node)
                // }
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
            throw new Error(`Unknown node: ${node.kind} ${node.getText()}`)
        }
    }
}

export class WrapperProcessor {
    readonly importExport: ImportExport
    readonly typeNodeConvertor: TypeNodeNameConvertor
    constructor(readonly typeChecker: ts.TypeChecker) {
        this.importExport = new ImportExport(this.typeChecker)
        this.typeNodeConvertor = new TSTypeNodeNameConvertor()
    }

    process(library: SkoalaLibrary) {
        for (let file of library.files) {
            for (let importDecl of file.draftImports) {
                let namedImportBindings = importDecl.importClause?.namedBindings
                let module = importDecl.moduleSpecifier.getText()
                if (namedImportBindings && ts.isNamedImports(namedImportBindings)) {
                    namedImportBindings.elements.forEach(importSpec => {
                        let realDeclaration = this.importExport.findRealDeclaration(importSpec.name)                        
                        file.importFeatures.add({
                            feature: importSpec.getText(),
                            module: module,
                            realDeclaration: realDeclaration,
                            kind: realDeclaration?.kind,
                        })
                    })
                } else if (namedImportBindings && ts.isNamespaceImport(namedImportBindings)) {
                    // xzy
                } else {
                    // xyz
                }
            }

            for (let decl of file.declarations) {
                if (ts.isClassDeclaration(decl) || ts.isInterfaceDeclaration(decl)) {
                    let result = this.tryProcessWrapper(decl)
                    if (result) {
                        // library.wrapperClasses.set(result.className, result)
                        file.declarations.delete(decl)
                        file.wrapperClasses.set(result.className, result)
                        continue
                    }
                }
            }
        }
    }

    private tryProcessWrapper(node: ts.InterfaceDeclaration | ts.ClassDeclaration): WrapperClass | undefined {
        let heritageClasses = this.findHeritageClasses(node)
        if (!heritageClasses?.length) return undefined

        let name = nameOrNull(node.name)!
        let isSuperClassWrapper = heritageClasses.length > 1
        let superClassName = heritageClasses.pop()!
        let constructor = ts.isClassDeclaration(node) ? node.members.find(ts.isConstructorDeclaration) : undefined
        let wConstructor = this.makeWrapperMethod(name, constructor, this.typeNodeConvertor)
        let wFields = ts.isInterfaceDeclaration(node)
            ? node.members
                .filter(ts.isPropertySignature)
                .map(it => this.makeWrapperField(name, it))
            : node.members
                .filter(ts.isPropertyDeclaration)
                .map(it => this.makeWrapperField(name, it))

        let wMethods = ts.isInterfaceDeclaration(node)
            ? node.members
                .filter(ts.isMethodSignature)
                .map(method => this.makeWrapperMethod(name, method, this.typeNodeConvertor))
            : node.members
                .filter(ts.isMethodDeclaration)
                .map(method => this.makeWrapperMethod(name, method, this.typeNodeConvertor))

        let wFinalizer = this.makeFinalizerMethod(name)

        return new WrapperClass(
            name,
            ts.isInterfaceDeclaration(node),
            superClassName,
            isSuperClassWrapper,
            wFields,
            wConstructor,
            wFinalizer,
            [], /*importFeatures: ImportFeature[],*/
            wMethods
        )
    }

    private makeWrapperField(className: string,
        property: ts.PropertyDeclaration | ts.PropertySignature
    ): WrapperField {
        return new WrapperField()
    }

    private makeWrapperMethod(parentName: string,
        method: ts.ConstructorDeclaration | ts.MethodDeclaration | ts.MethodSignature | undefined,
        typeNodeConverter: TypeNodeNameConvertor
    ): WrapperMethod {
        return new WrapperMethod(parentName, new Method(method ? (method.name?.getText() ?? "_") : "ctor", new NamedMethodSignature(Type.Void, [], []), []))
    }

    private makeFinalizerMethod(parentName: string): WrapperMethod {
        return new WrapperMethod(parentName, new Method("getFinalizer", new NamedMethodSignature(Type.Pointer, [], []), []))
    }

    private findHeritageClasses(declaration: ts.InterfaceDeclaration | ts.ClassDeclaration, heritageClasses: string[] = []): string[] | undefined {
        const superClassType = declaration.heritageClauses
            ?.filter(it => it.token == ts.SyntaxKind.ExtendsKeyword)[0]?.types[0]

        if (superClassType) {
            const superClassName = identName(superClassType.expression)!
            heritageClasses.push(superClassName)
            if (superClassName == "Finalizable" || superClassName == "RefCounted") {
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
