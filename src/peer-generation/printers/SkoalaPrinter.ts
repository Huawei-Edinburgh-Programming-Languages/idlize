import * as fs from "fs"
import * as path from "path"

interface IDLMethod {
    name: string
    returnType: string
    parameters: { name: string; type: string }[]
}

export class SkoalaCCodeGenerator {
    private idlContent: string
    private outputDir: string
    private fileName: string

    constructor(idlContent: string, outputDir: string, fileName: string) {
        this.idlContent = idlContent
        this.outputDir = outputDir
        this.fileName = fileName
    }

    public generate(): void {
        const parsedMethods = this.parseIDL(this.idlContent)
        if (parsedMethods.length === 0) {
            return
        }
        const cCode = this.generateCCode(parsedMethods)
        this.saveCCode(cCode)
    }

    private parseIDL(idlContent: string): IDLMethod[] {
        const methods: IDLMethod[] = []
        const methodRegex = /(\w+)\s+(\w+)\(([^)]*)\);/g
        let match

        while ((match = methodRegex.exec(idlContent)) !== null) {
            const returnType = match[1]
            const methodName = match[2]
            const params = match[3]
                .split(",")
                .map(param => param.trim())
                .filter(param => param)
                .map(param => {
                    const [type, name] = param.split(/\s+/)
                    return { name, type }
                })

            methods.push({ name: methodName, returnType, parameters: params })
        }

        return methods
    }

    private generateCCode(methods: IDLMethod[]): string {
        let cCode = `#include <stdio.h>\n#include <stdlib.h>\n\n`

        methods.forEach(method => {
            cCode += `void ${method.name}(`
            cCode += method.parameters.map(param => `${this.convertType(param.type)} ${param.name}`).join(", ")
            cCode += `) {\n    // TODO: Implement ${method.name}\n}\n\n`
        })

        return cCode
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
