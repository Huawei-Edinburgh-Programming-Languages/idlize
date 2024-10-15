import { IDLEntry, IDLInterface, isInterface, isClass, IDLType } from "../../idl"
import { IndentedPrinter } from "../../IndentedPrinter"

export class DeserializerPrinter {
    private entries: IDLEntry[]

    constructor(entries: IDLEntry[]) {
        this.entries = entries
    }

    public generateDeserializer(printer: IndentedPrinter): void {
        this.entries.forEach(entry => {
            if (isInterface(entry) || isClass(entry)) {
                this.visitDeserializer(entry as IDLInterface, printer)
            }
        })
    }

    private visitDeserializer(node: IDLInterface, printer: IndentedPrinter): void {
        const className = `Skoala_${node.name}`
        const deserializerName = `read${node.name}`
        printer.print(`${className} ${deserializerName}() {`)
        printer.pushIndent()
        printer.print(`${className} value = {};`)

        if (node.properties) {
            node.properties.forEach((property: any) => {
                const fieldName = property.name
                const fieldType = this.convertType(property.type.name)

                if (this.isPrimitiveType(fieldType)) {
                    const readMethod = this.getReadMethodForType(fieldType)
                    printer.print(`value.${fieldName} = this->${readMethod}();`)
                }
                else if (this.isArrayType(property.type)) {
                    const arrayElementType = this.getArrayElementType(property.type)
                    printer.print(`this->check(${this.getSizeOfType(arrayElementType)});`)
                    printer.print(`value.${fieldName} = this->readSkoala_${arrayElementType}Array();`)
                }
                else {
                    const readMethod = `read${fieldType}`
                    printer.print(`value.${fieldName} = this->${readMethod}();`)
                }
            })
        }

        if (node.constants) {
            node.constants.forEach((constant: any) => {
                const constName = constant.name
                const constType = this.convertType(constant.type.name)

                if (this.isPrimitiveType(constType)) {
                    const readMethod = this.getReadMethodForType(constType)
                    printer.print(`value.${constName} = this->${readMethod}();`)
                } else {
                    const readMethod = `read${constType}`
                    printer.print(`value.${constName} = this->${readMethod}();`)
                }
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
        const typeMapping: { [key: string]: string } = {
            "Int32": "read_Int32", 
            "Float32": "read_Float32",
            "Boolean": "read_Boolean",
            "String": "read_String",
        }
        return typeMapping[type] || `read_${type}`
    }
    

    private isArrayType(type: IDLType): boolean {
        return type.name.endsWith("[]")
    }

    private getArrayElementType(type: IDLType): string {
        return type.name.slice(0, -2)
    }

    private getSizeOfType(type: string): number {
        const sizeMapping: { [key: string]: number } = {
            "Int32": 4,
            "Float32": 4,
            "Boolean": 1,
            "String": 0, // Variable size
            "NativePointer": 8,
        }
        return sizeMapping[type] || 0
    }
}