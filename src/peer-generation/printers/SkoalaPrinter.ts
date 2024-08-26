import * as fs from "fs"
import * as path from "path"
import { IDLEntry, IDLMethod, IDLKind, IDLInterface } from "../../idl";

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
            .filter((method: IDLMethod) => method.kind === IDLKind.Method);
    }    
    
    private generateCCode(methods: IDLMethod[]): string {
        let cCode = `#include <stdio.h>\n#include <stdlib.h>\n\n`;
    
        methods.forEach(method => {
            cCode += `void ${method.name}(`;
            cCode += method.parameters
                .map(param => {
                    const typeName = param.type ? this.convertType(param.type.name) : "void*";
                    return `${typeName} ${param.name}`;
                })
                .join(", ");
            cCode += `) {\n    // TODO: Implement ${method.name}\n}\n\n`;
        });
    
        return cCode;
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

        const convertedType = typeMapping[idlType] || "void*"
        return convertedType
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
