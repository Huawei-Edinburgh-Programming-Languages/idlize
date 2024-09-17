import { LanguageWriter } from "../../peer-generation/LanguageWriters"
import { SkoalaFile, SkoalaLibrary } from "../SkoalaLibrary"

export class TSInterfacesVisitor {
    constructor() {
    }

    printInterfaces(file: SkoalaFile, writer: LanguageWriter) {
        file.declarations.forEach(decl => {
            writer.print(decl.getText())
        })
        file.variables.forEach(variable => {
            writer.print(variable.getText())
        })
        writer.print('\n')
    }
}
