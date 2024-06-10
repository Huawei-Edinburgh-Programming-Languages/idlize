import * as ts from 'typescript'
import { IndentedPrinter } from "../IndentedPrinter";
import { createLanguageWriter } from "./LanguageWriters";
import { PeerLibrary } from "./PeerLibrary";
import { DeclarationNameConvertor } from "./dependencies_collector";
import { convertDeclaration } from './TypeNodeConvertor';

class ConflictedDeclarationsVisitor {
    readonly writer = createLanguageWriter(new IndentedPrinter(), this.library.declarationTable.language)

    constructor(
        private readonly library: PeerLibrary
    ) {}

    print() {
        const printedNames = new Set<string>()
        for (const decl of this.library.conflictedDeclarations) {
            const name = convertDeclaration(DeclarationNameConvertor.I, decl)
            if (printedNames.has(name)) continue
            printedNames.add(name)

            const parent = decl.parent
            if (ts.isModuleBlock(parent)) {
                this.writer.print(`export namespace ${parent.parent.name.text} {`)
                this.writer.pushIndent()
            }

            let maybeGenerics = ''
            if (ts.isClassDeclaration(decl) || ts.isInterfaceDeclaration(decl))
                if (decl.typeParameters?.length)
                    maybeGenerics = `<${decl.typeParameters.map((_, i) => `T${i}=undefined`).join(',')}>`
            this.writer.print(`export type ${name}${maybeGenerics} = object;`)

            if (ts.isModuleBlock(parent)) {
                this.writer.popIndent()
                this.writer.print('}')
            }
        }
    }
}

export function printConflictedDeclarations(library: PeerLibrary): string {
    const visitor = new ConflictedDeclarationsVisitor(library)
    visitor.print()
    return visitor.writer.getOutput().join('\n')
}