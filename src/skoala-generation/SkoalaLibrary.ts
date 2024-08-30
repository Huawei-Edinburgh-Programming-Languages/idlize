import * as path from "path"
import * as ts from "typescript"
import { WrapperClass } from "./WrapperClass";

export type ImportFeature = { 
    feature: string, 
    module: string,
    realDeclaration?: ts.Declaration,
    kind?: ts.SyntaxKind
}

export class SkoalaFile {
    readonly declarations: Set<ts.Declaration> = new Set()
    readonly variables: ts.VariableStatement[] = []
    readonly wrapperClasses: Map<string, WrapperClass> = new Map()

    readonly draftImports: Set<ts.ImportDeclaration> = new Set()
    readonly importFeatures: Set<ImportFeature> = new Set()

    readonly name: string
    readonly baseName: string

    constructor(
        public readonly originalFile: ts.SourceFile
    ) {
        this.name = originalFile.fileName
        this.baseName = path.basename(this.name)
    }
}

export class SkoalaLibrary {
    public readonly files: SkoalaFile[] = []
}