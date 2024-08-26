import * as fs from "fs"
import * as path from "path"
import { IDLEntry, IDLMethod, IDLKind, IDLInterface } from "../../idl"
import { IndentedPrinter } from "../../IndentedPrinter"

export class SkoalaCCodeGenerator {
    private entries: IDLEntry[]
    private outputDir: string
    private fileName: string

    constructor(entries: IDLEntry[], outputDir: string, fileName: string) {
        this.entries = entries
        this.outputDir = outputDir
        this.fileName = fileName
    }

    public generate(): void {
        const methods = this.extractMethods(this.entries)
        if (methods.length === 0) {
            return
        }
        const cCode = this.generateCCode(methods)
        this.saveCCode(cCode)
    }

    private extractMethods(entries: IDLEntry[]): IDLMethod[] {
        return entries
            .filter(entry => entry.kind === IDLKind.Interface || entry.kind === IDLKind.Class)
            .flatMap(entry => (entry as IDLInterface).methods || [])
            .filter((method: IDLMethod) => method.kind === IDLKind.Method)
    }

    private generateCCode(methods: IDLMethod[]): string {
        const printer = new IndentedPrinter()

        printer.print("#include <stdio.h>")
        printer.print("#include <stdlib.h>")
        printer.print("")

        methods.forEach(method => {
            const returnType = method.returnType ? this.convertType(method.returnType.name) : "void"
            const signature = `${returnType} ${method.name}(`
            printer.print(signature)
        
            printer.pushIndent()
            const parameters = method.parameters
                .map(param => {
                    if (!param.type) {
                        throw new Error(`Parameter type is not defined for parameter ${param.name} in method ${method.name}`)
                    }
                    const typeName = this.convertType(param.type.name)
                    return `${typeName} ${param.name}`
                })
                .join(", ")
            printer.print(parameters)
            printer.popIndent()
        
            printer.print(") {")
            printer.pushIndent()
            printer.print(`// TODO: Implement ${method.name}`)
            
            if (returnType !== "void") {
                printer.print(`return (${returnType})0; // Placeholder return value`)
            }
        
            printer.popIndent()
            printer.print("}")
            printer.print("")
        })
        
        return printer.getOutput().join("\n")
    }

    private convertType(idlType: string): string {
        const typeMapping: { [key: string]: string } = {
            "float32": "float",
            "int32": "int",
            "uint32": "unsigned int",
            "boolean": "bool",
            "DOMString": "char*",
            "void_": "void",
        }

        return typeMapping[idlType] || "void*"
    }

    private saveCCode(cCode: string): void {
        const baseFileName = path.basename(this.fileName, ".d.ts")
        const outputFileName = `${baseFileName}.cc`
        const outputPath = path.join(this.outputDir, outputFileName)

        console.log("Saving C Code to:", outputPath)

        try {
            fs.writeFileSync(outputPath, cCode)
            console.log("C code generated and saved to:", outputPath)
        } catch (error) {
            console.error("Error saving C code:", error)
        }
    }
}
