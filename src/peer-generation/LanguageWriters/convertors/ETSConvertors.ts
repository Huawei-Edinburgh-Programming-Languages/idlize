import * as idl from "../../../idl";
import { TsIDLTypeToStringConverter } from "./TSConvertors";

export class EtsIDLTypeToStringConvertor extends TsIDLTypeToStringConverter {
    override convertContainer(type: idl.IDLContainerType): string {
        if (idl.IDLContainerUtils.isSequence(type)) {
            switch (type.elementType[0]) {
                case idl.IDLU8Type: return 'KUint8ArrayPtr'
                case idl.IDLI32Type: return 'KInt32ArrayPtr'
                case idl.IDLF32Type: return 'KFloat32ArrayPtr'
            }
            return `Array<${this.convert(type.elementType[0])}>`
        }
        return super.convertContainer(type)
    }
    override convertPrimitiveType(type: idl.IDLPrimitiveType): string {
        switch (type) {
            case idl.IDLAnyType: return "object"
            case idl.IDLUnknownType: return "object"

            case idl.IDLPointerType: return 'KPointer'
            case idl.IDLVoidType: return 'void'
            case idl.IDLBooleanType: return 'boolean'
            
            case idl.IDLU8Type:
            case idl.IDLI8Type:
            case idl.IDLI16Type:
            case idl.IDLU16Type:
            case idl.IDLI32Type:
            case idl.IDLU32Type:
                return 'KInt'

            case idl.IDLI64Type:
            case idl.IDLU64Type:
                return 'KLong'

            case idl.IDLF32Type:
                return 'KFloat'

            case idl.IDLF64Type:
            case idl.IDLNumberType:
                return 'number'

            case idl.IDLStringType: return 'KStringPtr'
            case idl.IDLFunctionType: return 'Object'
        }
        return super.convertPrimitiveType(type)
    }
    protected override productType(decl: idl.IDLInterface, isTuple: boolean, includeFieldNames: boolean): string {
        if (idl.isAnonymousInterface(decl)) {
            return decl.name
        }
        return super.productType(decl, isTuple, includeFieldNames)
    }
    protected override processTupleType(idlProperty: idl.IDLProperty): idl.IDLProperty {
        if (idlProperty.isOptional) {
            return {
                ...idlProperty,
                isOptional: false,
                type: idl.createUnionType([idlProperty.type, idl.IDLUndefinedType])
            }
        }
        return idlProperty
    }
}
