import { IDLEntry, IDLInterface, isInterface, isClass, IDLType } from "../../idl"
import { IndentedPrinter } from "../../IndentedPrinter"

export class SKoalaDeserializerPrinter {
    private entries: IDLEntry[]

    constructor(entries: IDLEntry[]) {
        this.entries = entries
    }

    public generateSKoalaDeserializer(printer: IndentedPrinter): void {
        this.entries.forEach(entry => {
            if (isInterface(entry) || isClass(entry)) {
                this.visitSKoalaDeserializer(entry as IDLInterface, printer)
            }
        })
    }

    private visitSKoalaDeserializer(node: IDLInterface, printer: IndentedPrinter): void {
        const className = `Skoala_${node.name}`
        const deserializerName = `read${node.name}`
        printer.print(`${className} ${deserializerName}(DeserializerBase deserializer) {`)
        printer.pushIndent()
        printer.print(`${className} value = {};`)

        if (node.properties) {
            node.properties.forEach((property: any) => {
                const fieldName = property.name
                const fieldType = this.convertType(property.type.name)

                if (this.isPrimitiveType(fieldType)) {
                    const readMethod = this.getReadMethodForType(fieldType)
                    printer.print(`value.${fieldName} = deserializer.${readMethod}();`)
                } else {
                    const readMethod = `read${fieldType}`
                    printer.print(`value.${fieldName} = deserializer.${readMethod}();`)
                }
            });
        }

        if (node.constants) {
            node.constants.forEach((constant: any) => {
                const constName = constant.name
                const constType = this.convertType(constant.type.name)
                const readMethod = `read${constType}`
                printer.print(`value.${constName} = deserializer.${readMethod}();`)
            })
        }

        printer.print(`return value;`)
        printer.popIndent()
        printer.print("}")
        printer.print("")
    }

    private convertType(idlType: string): string {
        const typeMapping: { [key: string]: string } = {
            "float32": "Float32",
            "int32": "Int32",
            "uint32": "UInt32",
            "boolean": "Boolean",
            "DOMString": "String",
            "void_": "void",
            "KNativePointer": "NativePointer",
        }

        return typeMapping[idlType] || idlType
    }

    private isPrimitiveType(type: string): boolean {
        const primitiveTypes = ["Int32", "Float32", "Boolean", "String"]
        return primitiveTypes.includes(type)
    }

    private getReadMethodForType(type: string): string {
        return `read${type}`
    }
}
