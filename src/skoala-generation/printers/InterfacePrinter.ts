import * as path from "path"
import { createLanguageWriter, LanguageWriter } from "../../peer-generation/LanguageWriters"
import { TargetFile } from "../../peer-generation/printers/TargetFile"
import { Language, snakeCaseToCamelCase } from "../../util"
import { SkoalaFile, SkoalaLibrary } from "../SkoalaLibrary"
import { PrinterContext } from "../../peer-generation/printers/PrinterContext"

interface InterfacesVisitor {
    getInterfaces(): Map<TargetFile, LanguageWriter>
    printInterfaces(): void
}

abstract class DefaultInterfacesVisitor implements InterfacesVisitor {
    protected readonly interfaces: Map<TargetFile, LanguageWriter> = new Map()
    getInterfaces(): Map<TargetFile, LanguageWriter> {
        return this.interfaces
    }
    abstract printInterfaces(): void
}

class TSInterfacesVisitor extends DefaultInterfacesVisitor {
    constructor(protected readonly skoalaLibrary: SkoalaLibrary) {
        super()
    }

    printInterfaces() {
        for (const file of this.skoalaLibrary.files.values()) {
            const writer = createLanguageWriter(Language.TS)
            
            file.draftImports.forEach(imprt => {
                writer.print(imprt.getText())
            })
            if (file.wrapperClasses.size) {
                writer.print(`import { nativeModule } from "@koalaui/arkoala"`)
            }
            file.declarations.forEach(decl => {
                writer.print(decl.getText())
            })
            file.variables.forEach(variable => {
                writer.print(variable.getText())
            })
            
            this.interfaces.set(
                new TargetFile(getInterfaceFilename(file.baseName)),
                writer
            )
            writer.print('\n')

            // const typeConvertor = new TSDeclConvertor(writer, this.skoalaLibrary)
            // file.declarations.forEach(it => convertDeclaration(typeConvertor, it))
            // file.enums.forEach(it => writer.writeStatement(writer.makeEnumEntity(it, true)))
            // this.printAssignEnumsToGlobalScope(writer, file)
        }
    }
}

export function getInterfaceFilename(fileName: string) {
    const renamed = snakeCaseToCamelCase(fileName)
        // .concat("Interfaces")
        .replace(".d.ts", "")
    return renamed.concat(Language.TS.extension)
}

export function printInterfaces(peerLibrary: SkoalaLibrary): Map<TargetFile, string> {
    const visitor = new TSInterfacesVisitor(peerLibrary)
    if (!visitor) {
        return new Map()
    }

    visitor.printInterfaces()
    const result = new Map<TargetFile, string>()
    for (const [key, writer] of visitor.getInterfaces()) {
        if (writer.getOutput().length === 0) continue
        result.set(key, writer.getOutput().join('\n'))
    }
    return result
}