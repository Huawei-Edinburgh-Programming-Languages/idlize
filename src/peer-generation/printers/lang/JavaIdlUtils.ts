import * as idl from "../../../idl"
import { convertType, TypeConvertor } from "../../idl/IdlTypeConvertor"

class JavaImportsCollector implements TypeConvertor<string[]> {
    convertUnion(type: idl.IDLUnionType): string[] {
        return []
    }
    convertContainer(type: idl.IDLContainerType): string[] {
        const result = type.elementType.flatMap(ty => convertType(this, ty))
        if (type.name == "record") {
            result.push("java.util.Map")
        }
        return result
    }
    convertEnum(type: idl.IDLEnumType): string[] {
        return []
    }
    convertImport(type: idl.IDLReferenceType, importClause: string): string[] {
        return []
    }
    convertTypeReference(type: idl.IDLReferenceType): string[] {
        return []
    }
    convertTypeParameter(type: idl.IDLTypeParameterType): string[] {
        return []
    }
    convertPrimitiveType(type: idl.IDLPrimitiveType): string[] {
        return []
    }
    convertCallback(decl: idl.IDLCallback): string[] {
        // TODO: add types like Consumer/Supplier/...
        return [
            ...decl.parameters.flatMap(it => convertType(this, it.type!)),
            ...convertType(this, decl.returnType),
        ]
    }
    convert(node: idl.IDLType | undefined): string[] {
        return node ? convertType(this, node) : []
    }
}

export function collectJavaImports(nodes: idl.IDLType[]): string[] {
    const collector = new JavaImportsCollector()
    const allImports = nodes.flatMap(node => collector.convert(node))
    return Array.from(new Set(allImports))
}
