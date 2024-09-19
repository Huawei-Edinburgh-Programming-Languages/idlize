import * as path from "path"
import * as ts from "typescript"
import { WrapperClass } from "./WrapperClass";
import { Library } from "../Library";
import { Language } from "../util";


export class SkoalaFile {
    readonly declarations: Set<ts.Declaration> = new Set()
    readonly variables: ts.VariableStatement[] = []
    readonly wrapperClasses: Map<string, WrapperClass> = new Map()

    readonly draftImports: Set<ts.ImportDeclaration> = new Set()
    readonly importFeatures: Map<string, Set<string>> = new Map()

    readonly originalFilename: string
    readonly baseName: string

    constructor(
        public readonly originalFile: ts.SourceFile
    ) {
        this.originalFilename = originalFile.fileName
        this.baseName = path.basename(this.originalFilename)
    }

    addImportFeature(module: string, features: string[]) {
        if (this.importFeatures.has(module)) {
            features.forEach(f => {
                this.importFeatures.get(module)?.add(f)
            })
        } else {
            this.importFeatures.set(module, new Set(features))
        }
    }
}

export class SkoalaLibrary implements Library<SkoalaFile> {
    constructor(public typeChecker: ts.TypeChecker) { }
    public readonly serializerDeclarations: Set<ts.ClassDeclaration | ts.InterfaceDeclaration> = new Set()
    public readonly files: SkoalaFile[] = []
    get language(): Language {
        return Language.TS
    }
    findFileByOriginalFilename(filename: string): SkoalaFile | undefined {
        return this.files.find(it => it.originalFilename === filename)
    }
}