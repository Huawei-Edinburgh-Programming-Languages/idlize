import * as ts from "typescript"
import { convertDeclToFeature, ImportFeature, ImportsCollector } from "../ImportsCollector";
import { PeerLibrary } from "../PeerLibrary";
import {
    DeclarationDependenciesCollector,
    DeclarationNameConvertor
} from "../dependencies_collector";
import { convertDeclaration } from "../TypeNodeConvertor";
import { createLanguageWriter, LanguageExpression, LanguageWriter, Method, MethodModifier, NamedMethodSignature, Type } from "../LanguageWriters";
import { Language } from "../../util";
import { StructDescriptor } from "../DeclarationTable";
import { createTypeDependenciesCollector, isSourceDecl } from "../PeerGeneratorVisitor";
import { lazy } from "../lazy";
import { isSyntheticDeclaration } from "../synthetic_declaration";

export function importTypeChecker(library: PeerLibrary, imports: ImportsCollector): void {
    imports.addFeature("TypeChecker", "#arkui/type_check")
}

export function makeEnumTypeCheckerCall(valueAccessor: string, enumName: string, writer: LanguageWriter): LanguageExpression {
    return writer.makeMethodCall(
        "TypeChecker", 
        generateTypeCheckerName(enumName),
        [writer.makeString(valueAccessor)]
    )
}

export function makeInterfaceTypeCheckerCall(
    valueAccessor: string, 
    interfaceName: string, 
    allFields: string[], 
    duplicates: Set<string>, 
    writer: LanguageWriter,
): LanguageExpression {
    if (interfaceName == "Resource") {
        // todo stub or not?
        return writer.makeCallIsResource(valueAccessor)
    }
    if (interfaceName == "Object") {
        // todo stub or not?
        return writer.makeString(`${valueAccessor} instanceof Object`)
    }
    if (interfaceName == "ArrayBuffer") {
        // todo stub or not?
        return writer.makeString(`${valueAccessor} instanceof ArrayBuffer`)
    }
    return writer.makeMethodCall(
        "TypeChecker",
        generateTypeCheckerName(interfaceName), [writer.makeString(valueAccessor),
        ...allFields.map(it => {
            return writer.makeString(duplicates.has(it) ? "true" : "false")
        })
    ])
}

export function makeArrayTypeCheckCall(
    valueAccessor: string, 
    typeName: string,
    writer: LanguageWriter,
) {
    return writer.makeMethodCall(
        "TypeChecker",
        generateTypeCheckerName(typeName),
        // isBrackets ? generateTypeCheckerNameBracketsArray(typeName) : generateTypeCheckerNameArray(typeName), 
        [writer.makeString(valueAccessor)
    ])
}

export function generateTypeCheckerName(typeName: string): string {
    typeName = typeName.replaceAll('[]', 'BracketsArray')
    return `is${typeName.replaceAll('[]', 'Brackets')}`
}

abstract class TypeCheckerPrinter {
    private readonly declDependenciesCollector: DeclarationDependenciesCollector
    constructor(
        protected readonly library: PeerLibrary,
        public readonly writer: LanguageWriter,
    ) {
        this.declDependenciesCollector = new DeclarationDependenciesCollector(
            this.library.declarationTable.typeChecker!,
            createTypeDependenciesCollector(this.library, {
                declDependenciesCollector: lazy(() => this.declDependenciesCollector)
            })
        )
    }

    protected writeImports(features: ImportFeature[]): void {
        const imports = new ImportsCollector()
        for (const feature of features) {
            imports.addFeature(feature.feature, feature.module)
        }
        for (const file of this.library.files)
            for (const feature of file.serializeImportFeatures)
                imports.addFeature(feature.feature, feature.module)
        imports.print(this.writer, 'arkts/type_check')
    }
    protected abstract writeInterfaceChecker(name: string, descriptor: StructDescriptor): void
    protected abstract writeArrayChecker(typeName: string): void

    print() {
        const importFeatures: ImportFeature[] = []
        const interfaces: { name: string, descriptor: StructDescriptor }[] = []
        for (const file of this.library.files) {
            for (const decl of file.declarations) {
                if (ts.isTypeAliasDeclaration(decl) && ts.isTypeLiteralNode(decl.type)) {
                    importFeatures.push(convertDeclToFeature(this.library, decl))
                    interfaces.push({
                        name: convertDeclaration(DeclarationNameConvertor.I, decl),
                        descriptor: this.library.declarationTable.targetStruct(decl.type)
                    })
                } else if (ts.isInterfaceDeclaration(decl)) {
                    importFeatures.push(convertDeclToFeature(this.library, decl))
                    interfaces.push({
                        name: convertDeclaration(DeclarationNameConvertor.I, decl),
                        descriptor: this.library.declarationTable.targetStruct(decl)
                    })
                }

                // Collecting of synthetic types. This is necessary for the arkts
                this.collectSyntheticInterfaces(decl).forEach(it => {
                    const declName = convertDeclaration(DeclarationNameConvertor.I, it)
                    if (interfaces.find(it => it.name === declName) === undefined) {
                        importFeatures.push(convertDeclToFeature(this.library, it))
                        interfaces.push({
                            name: declName,
                            descriptor: this.library.declarationTable.targetStruct(it)
                        })
                    }
                })
            }
        }

        this.writeImports(importFeatures)
        this.writer.writeClass("TypeChecker", writer => {
            for (const struct of interfaces) 
                this.writeInterfaceChecker(struct.name, struct.descriptor)
            const writtenTypes = new Set()
            for (const arrayType of this.library.arrayTypeCheckeres) {
                if (!writtenTypes.has(arrayType)) {
                    this.writeArrayChecker(arrayType)
                    writtenTypes.add(arrayType)
                }
            }
        })
    }

    private collectSyntheticInterfaces(decl: ts.Declaration): ts.InterfaceDeclaration[] {
        const total = new Set<ts.InterfaceDeclaration>()
        const deps = convertDeclaration(this.declDependenciesCollector, decl)
            .filter(isSyntheticDeclaration)
            .filter(ts.isInterfaceDeclaration)
        while (deps.length > 0) {
            const dep = deps.splice(0, 1)[0]
            if (total.has(dep) || !isSourceDecl(dep)) {
                continue
            }
            total.add(dep)
            deps.push(...convertDeclaration(this.declDependenciesCollector, dep)
                .filter(isSyntheticDeclaration)
                .filter(ts.isInterfaceDeclaration)
            )
        }
        return [...total]
    }
}

class ARKTSTypeCheckerPrinter extends TypeCheckerPrinter {
    constructor(
        library: PeerLibrary
    ) {
        super(library, createLanguageWriter(Language.ARKTS))
    }

    private writeInstanceofChecker(typeName: string, checkerName: string, fieldsCount: number) {
        const argsNames = Array.from({length: fieldsCount}, (_, index) => `arg${index}`)
        this.writer.writeMethodImplementation(new Method(
            checkerName,
            new NamedMethodSignature(Type.Boolean, 
                [new Type('object|string|number|undefined|null'), ...argsNames.map(_ => Type.Boolean)], 
                ['value', ...argsNames]),
            [MethodModifier.STATIC],
        ), writer => {
            const statement = writer.makeReturn(writer.makeString(`value instanceof ${typeName}`))
            writer.writeStatement(statement)
        })
    }

    protected writeInterfaceChecker(name: string, descriptor: StructDescriptor): void {
        this.writeInstanceofChecker(name, generateTypeCheckerName(name), descriptor.getFields().length)
    }

    protected writeArrayChecker(typeName: string): void {
        this.writeInstanceofChecker(typeName, generateTypeCheckerName(typeName), 0)
    }
}

class TSTypeCheckerPrinter extends TypeCheckerPrinter {
    constructor(
        library: PeerLibrary
    ) {
        super(library, createLanguageWriter(Language.TS))
    }

    protected writeInterfaceChecker(name: string, descriptor: StructDescriptor): void {
        if (descriptor.getFields().length === 0)
            return
        const argsNames = descriptor.getFields().map(it => `duplicated_${it.name}`)
        this.writer.writeMethodImplementation(new Method(
            generateTypeCheckerName(name),
            new NamedMethodSignature(Type.Boolean, 
                [new Type('object|string|number|undefined|null'), ...argsNames.map(_ => Type.Boolean)], 
                ['value', ...argsNames]),
            [MethodModifier.STATIC],
        ), writer => {
            const orderedFields = Array.from(descriptor.getFields()).sort((a, b) => {
                const aWeight = a.optional ? 1 : 0
                const bWeight = b.optional ? 1 : 0
                return aWeight - bWeight
            })
            const statement = writer.makeMultiBranchCondition(orderedFields.map(it => {
                return {
                    expr: writer.makeNaryOp("&&", [
                        writer.makeString(`!duplicated_${it.name}`),
                        writer.makeString(`value?.hasOwnProperty("${it.name}")`)
                    ]),
                    stmt: writer.makeReturn(writer.makeString('true'))
                }
            }), writer.makeThrowError(`Can not discriminate value typeof ${name}`))
            writer.writeStatement(statement)
        })
    }

    protected writeArrayChecker(typeName: string) {
        const checkerName = generateTypeCheckerName(typeName)
        this.writer.writeMethodImplementation(new Method(
            checkerName,
            new NamedMethodSignature(Type.Boolean, [new Type('object|string|number|undefined|null')], ['value']),
            [MethodModifier.STATIC],
        ), writer => {
            writer.writeStatement(writer.makeReturn(writer.makeString(`Array.isArray(value)`)))
        })
    }
}

export function writeARKTSTypeCheckers(library: PeerLibrary, printer: LanguageWriter) {
    const checker = new ARKTSTypeCheckerPrinter(library)
    checker.print()
    printer.concat(checker.writer)
}

export function writeTSTypeCheckers(library: PeerLibrary, printer: LanguageWriter) {
    const checker = new TSTypeCheckerPrinter(library)
    checker.print()
    printer.concat(checker.writer)
}