import * as ts from 'typescript'
import { ImportFeature, SkoalaFile, SkoalaLibrary } from "./SkoalaLibrary";
import { GenericVisitor } from '../options';
import { getDeclarationsByNode, identName, nameOrNull } from '../util';
import { WrapperClass, WrapperField, WrapperMethod } from './WrapperClass';
import { ImportExport } from './ImportExport';
import { TypeNodeConvertor } from '../peer-generation/TypeNodeConvertor';
import { TSTypeNodeNameConvertor, TypeNodeNameConvertor } from '../peer-generation/TypeNodeNameConvertor';
import { Field, FieldModifier, Method, MethodModifier, MethodSignature, NamedMethodSignature, Type } from '../peer-generation/LanguageWriters';
import { Skoala } from './utils';

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
                // let namedImportBindings = importDecl.importClause?.namedBindings
                // let module = importDecl.moduleSpecifier.getText()
                // if (namedImportBindings && ts.isNamedImports(namedImportBindings)) {
                //     namedImportBindings.elements.forEach(importSpec => {
                //         let realDeclaration = this.importExport.findRealDeclaration(importSpec.name)                        
                //         file.importFeatures.add({
                //             feature: importSpec.getText(),
                //             module: module,
                //             realDeclaration: realDeclaration,
                //             kind: realDeclaration?.kind,
                //         })
                //     })
                // } else if (namedImportBindings && ts.isNamespaceImport(namedImportBindings)) {
                //     // xzy
                // } else {
                //     // xyz
                // }
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
        // todo: save heritage classes somewhere

        let name = nameOrNull(node.name)!
        let isSuperClassWrapper = heritageClasses.length > 1
        let superClassName = heritageClasses.reverse().pop()!
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
        
        let wImports = this.collectRequiredImports(node)

        return new WrapperClass(
            name,
            ts.isInterfaceDeclaration(node),
            superClassName,
            isSuperClassWrapper,
            wFields,
            wConstructor,
            wFinalizer,
            wImports,
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
        method: ts.ConstructorDeclaration | ts.MethodDeclaration | ts.MethodSignature,
        typeNodeConverter: TypeNodeNameConvertor
    ): WrapperMethod {
        // TODO: add convertor to convers method.type, method.name, method.parameters[..].type, method.parameters[..].name
        // TODO: add arg and ret convertors
        let args: Type[] = []
        let argsNames: string[] = []
        method.parameters.forEach(param => {
            args.push(new Type(param.type?.getText() ?? ""))
            argsNames.push(param.name.getText())
        })

        let modifiers: MethodModifier[] = []
        method.modifiers?.forEach(modifier => {
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

        if (ts.isConstructorDeclaration(method)) {
            return new WrapperMethod(parentName, new Method("constructor", new NamedMethodSignature(Type.Void, args, argsNames), modifiers))
        } else {
            if (ts.isGetAccessor(method)) modifiers.push(MethodModifier.GETTER)
            if (ts.isSetAccessor(method)) modifiers.push(MethodModifier.SETTER)
            return new WrapperMethod(parentName, new Method(method.name.getText(), new NamedMethodSignature(new Type(method.type?.getText() ?? ""), args, argsNames), modifiers))
        }
    }

    private collectRequiredImports(node: ts.InterfaceDeclaration | ts.ClassDeclaration): ImportFeature[] {
        let importFeatures: ImportFeature[] = []
        let methods = ts.isClassDeclaration(node) ? node.members.filter(ts.isMethodDeclaration) : node.members.filter(ts.isMethodSignature)
        methods.forEach(it => {
            if (it.name.getText().startsWith('make')) {
                importFeatures.push({
                    feature: "isNullPtr",
                    module: "@koalaui/interop",
                })
            }
        })
        return importFeatures
    }

    private findHeritageClasses(declaration: ts.InterfaceDeclaration | ts.ClassDeclaration, heritageClasses: string[] = []): string[] | undefined {
        const superClassType = declaration.heritageClauses
            ?.filter(it => it.token == ts.SyntaxKind.ExtendsKeyword)[0]?.types[0]

        if (superClassType) {
            const superClassName = identName(superClassType.expression)!
            heritageClasses.push(superClassName)
            if (superClassName == Skoala.Finalizable || superClassName == Skoala.RefCounted) {
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
