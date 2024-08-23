import * as fs from "fs"
import * as path from "path"

interface IDLMethod {
    name: string
    returnType: string
    parameters: { name: string; type: string }[]
}

export class SkoalaCCodeGenerator {
    private idlFilePath: string
    private outputDir: string

    constructor(idlFilePath: string, outputDir: string) {
        this.idlFilePath = idlFilePath
        this.outputDir = outputDir
    }

    public generate(): void {
        const idlContent = fs.readFileSync(this.idlFilePath, "utf-8")
        const parsedMethods = this.parseIDL(idlContent)
        const cCode = this.generateCCode(parsedMethods)
        this.saveCCode(cCode)
    }

    private parseIDL(idlContent: string): IDLMethod[] {
        const methods: IDLMethod[] = []
        const methodRegex = /void_\s+(\w+)\(([^)]*)\);/g
        let match

        while ((match = methodRegex.exec(idlContent)) !== null) {
            const methodName = match[1]
            const params = match[2]
                .split(",")
                .map(param => param.trim())
                .filter(param => param)
                .map(param => {
                    const [type, name] = param.split(/\s+/)
                    return { name, type }
                })

            methods.push({ name: methodName, returnType: "void", parameters: params })
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

        return typeMapping[idlType] || "void*" // By default, return a pointer to void
    }

    private saveCCode(cCode: string): void {
        const fileName = path.basename(this.idlFilePath, ".idl") + ".cc"
        const outputPath = path.join(this.outputDir, fileName)
        fs.writeFileSync(outputPath, cCode)
    }
}
