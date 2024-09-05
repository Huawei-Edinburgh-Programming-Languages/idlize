import { LanguageWriter } from "../../peer-generation/LanguageWriters"
import { SkoalaFile, SkoalaLibrary } from "../SkoalaLibrary"

export class TSInterfacesVisitor {
    constructor() {
    }

    printImports(file: SkoalaFile, writer: LanguageWriter) {
        file.draftImports.forEach(imprt => {
            writer.print(imprt.getText())
        })
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
