import * as path from "path"
import * as ts from "typescript"
import { WrapperClass } from "./WrapperClass";
import { Library } from "../Library";
import { Language } from "../util";

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

    readonly originalFilename: string
    readonly baseName: string

    constructor(
        public readonly originalFile: ts.SourceFile
    ) {
        this.originalFilename = originalFile.fileName
        this.baseName = path.basename(this.originalFilename)
    }
}

export class SkoalaLibrary implements Library<SkoalaFile> {
    public readonly files: SkoalaFile[] = []
    get language(): Language {
        return Language.TS
    }
    findFileByOriginalFilename(filename: string): SkoalaFile | undefined {
        return this.files.find(it => it.originalFilename === filename)
    }
}