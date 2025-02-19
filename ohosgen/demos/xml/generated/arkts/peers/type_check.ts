import { KBoolean, KStringPtr, NativeBuffer, MaterializedBase } from "@koalaui/interop"
import { xml, xml_EventType } from "./../OHXmlNamespace"
export class TypeChecker {
    static typeInstanceOf<T>(value: Object, prop: string): boolean {
        return value instanceof T
    }
    static typeCast<T>(value: Object): T {
        return value as T
    }
    static isxml_EventType(value: object|string|number|undefined|null): boolean {
        return value instanceof xml_EventType
    }
    static isxmlParseInfo(value: object|string|number|undefined|null): boolean {
        return value instanceof xml.ParseInfo
    }
    static isxmlParseOptions(value: object|string|number|undefined|null, arg0: boolean, arg1: boolean, arg2: boolean, arg3: boolean, arg4: boolean): boolean {
        return value instanceof xml.ParseOptions
    }
    static isxmlPoint(value: object|string|number|undefined|null, arg0: boolean, arg1: boolean): boolean {
        return value instanceof xml.Point
    }
    static isxmlXmlPullParser(value: object|string|number|undefined|null): boolean {
        return value instanceof xml.XmlPullParser
    }
    static isxmlXmlSerializer(value: object|string|number|undefined|null): boolean {
        return value instanceof xml.XmlSerializer
    }
}