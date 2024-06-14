import { DeclarationGenerator } from "./InterfacePrinter";
import { createLanguageWriter } from "./LanguageWriters";
import { PeerLibrary } from "./PeerLibrary";
import { convertDeclaration } from "./TypeNodeConvertor";
import { makeFakeDeclarationsFiles } from "./fake_declaration";

export function printFakeDeclarations(library: PeerLibrary): Map<string, string> {
    const lang = library.declarationTable.language
    const declarationGenerator = new DeclarationGenerator(library)
    const result = new Map<string, string>()
    for (const [filename, nodes] of makeFakeDeclarationsFiles()) {
        const writer = createLanguageWriter(lang)
        for (const node of nodes) {
            writer.print(convertDeclaration(declarationGenerator, node))
        }
        result.set(`${filename}${lang.extension}`, writer.getOutput().join('\n'))
    }
    return result
}