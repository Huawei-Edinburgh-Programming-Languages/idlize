import { pointer, int32, EventType, KPointer } from "./types"
import { SerializerBase, Tags, RuntimeType, runtimeType, isInstanceOf, unsafeCast } from "./SerializerBase"
import { Serializer, createSerializer } from "./xmlSerializer"

import {
    XMLNativeModule,
    getXMLNativeModule,
} from './xmlNative'
export interface ParseOptions {
     supportDoctype: boolean
     ignoreNameSpace: boolean
     tagValueCallbackFunction: ((name: string, value: string) => boolean)
     attributeValueCallbackFunction: ((name: string, value: string) => boolean)
     tokenValueCallbackFunction: ((eventType: EventType, value: ParseInfo) => boolean)
}
export interface XmlSerializerInterface {
    setAttributes(name: string, value: string): void 
    addEmptyElement(name: string): void 
    setDeclaration(): void 
    startElement(name: string): void 
    endElement(): void 
    setNamespace(prefix: string, namespace: string): void 
    setComment(text: string): void 
    setCDATA(text: string): void 
    setText(text: string): void 
    setDocType(text: string): void 
}
export interface ParseInfoInterface {
    getColumnNumber(): number 
    getDepth(): number 
    getLineNumber(): number 
    getName(): string 
    getNamespace(): string 
    getPrefix(): string 
    getText(): string 
    isEmptyElementTag(): boolean 
    isWhitespace(): boolean 
    getAttributeCount(): number 
}
export interface XmlPullParserInterface {
    parse(option: ParseOptions): void 
}
export class XmlSerializer implements XmlSerializerInterface {
    private peer: KPointer
     constructor(buffer: ArrayBuffer | DataView, encoding: string) {
        const thisSerializer: Serializer = SerializerBase.hold(createSerializer)
        let buffer_type: int32 = RuntimeType.UNDEFINED
        buffer_type = runtimeType(buffer)
        if (((RuntimeType.OBJECT) == (buffer_type)) && (((buffer!.hasOwnProperty("byteLength"))))) {
            thisSerializer.writeInt8(0)
            const buffer_0 = unsafeCast<ArrayBuffer>(buffer)
            thisSerializer.writeArrayBuffer(buffer_0)
        }
        else if (((RuntimeType.OBJECT == buffer_type))) {
            thisSerializer.writeInt8(1)
            const buffer_1 = unsafeCast<DataView>(buffer)
            thisSerializer.writeCustomObject("DataView", buffer_1)
        }
        let encoding_type: int32 = RuntimeType.UNDEFINED
        encoding_type = runtimeType(encoding)
        thisSerializer.writeInt8(encoding_type)
        if ((RuntimeType.UNDEFINED) != (encoding_type)) {
            const encoding_value = encoding!
            thisSerializer.writeString(encoding_value)
        }
        this.peer = getXMLNativeModule()._XmlSerializer_ctor(thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release();
    }
    setAttributes(name: string, value: string): void {
        getXMLNativeModule()._XML_setAttributes(this.peer, name, value);
    }
    addEmptyElement(name: string): void {
        getXMLNativeModule()._XML_addEmptyElement(this.peer, name);
    }
    setDeclaration(): void {
        getXMLNativeModule()._XML_setDeclaration(this.peer);
    }
    startElement(name: string): void {
        getXMLNativeModule()._XML_startElement(this.peer, name);
    }
    endElement(): void {
        getXMLNativeModule()._XML_endElement(this.peer);
    }
    setNamespace(prefix: string, namespace: string): void {
        getXMLNativeModule()._XML_setNamespace(this.peer, prefix, namespace);
    }
    setComment(text: string): void {
        getXMLNativeModule()._XML_setComment(this.peer, text);
    }
    setCDATA(text: string): void {
        getXMLNativeModule()._XML_setCDATA(this.peer, text);
    }
    setText(text: string): void {
        getXMLNativeModule()._XML_setText(this.peer, text);
    }
    setDocType(text: string): void {
        getXMLNativeModule()._XML_setDocType(this.peer, text);
    }
}
export class ParseInfo implements ParseInfoInterface {
    private peer: KPointer
     constructor() {
        this.peer = getXMLNativeModule()._ParseInfo_ctor()
    }
    getColumnNumber(): number {
        const result = getXMLNativeModule()._XML_getColumnNumber(this.peer)
        return result
    }
    getDepth(): number {
        const result = getXMLNativeModule()._XML_getDepth(this.peer)
        return result
    }
    getLineNumber(): number {
        const result = getXMLNativeModule()._XML_getLineNumber(this.peer)
        return result
    }
    getName(): string {
        const result = getXMLNativeModule()._XML_getName(this.peer)
        return result
    }
    getNamespace(): string {
        const result = getXMLNativeModule()._XML_getNamespace(this.peer)
        return result
    }
    getPrefix(): string {
        const result = getXMLNativeModule()._XML_getPrefix(this.peer)
        return result
    }
    getText(): string {
        const result = getXMLNativeModule()._XML_getText(this.peer)
        return result
    }
    isEmptyElementTag(): boolean {
        const result = getXMLNativeModule()._XML_isEmptyElementTag(this.peer)
        return result
    }
    isWhitespace(): boolean {
        const result = getXMLNativeModule()._XML_isWhitespace(this.peer)
        return result
    }
    getAttributeCount(): number {
        const result = getXMLNativeModule()._XML_getAttributeCount(this.peer)
        return result
    }
}
export class XmlPullParser implements XmlPullParserInterface {
    private peer: KPointer
     constructor(buffer: ArrayBuffer | DataView, encoding: string) {
        const thisSerializer: Serializer = SerializerBase.hold(createSerializer)
        let buffer_type: int32 = RuntimeType.UNDEFINED
        buffer_type = runtimeType(buffer)
        if (((RuntimeType.OBJECT) == (buffer_type)) && (((buffer!.hasOwnProperty("byteLength"))))) {
            thisSerializer.writeInt8(0)
            const buffer_0 = unsafeCast<ArrayBuffer>(buffer)
            thisSerializer.writeArrayBuffer(buffer_0)
        }
        else if (((RuntimeType.OBJECT == buffer_type))) {
            thisSerializer.writeInt8(1)
            const buffer_1 = unsafeCast<DataView>(buffer)
            thisSerializer.writeCustomObject("DataView", buffer_1)
        }
        let encoding_type: int32 = RuntimeType.UNDEFINED
        encoding_type = runtimeType(encoding)
        thisSerializer.writeInt8(encoding_type)
        if ((RuntimeType.UNDEFINED) != (encoding_type)) {
            const encoding_value = encoding!
            thisSerializer.writeString(encoding_value)
        }
        this.peer = getXMLNativeModule()._XmlPullParser_ctor(thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release();
    }
    parse(option: ParseOptions): void {
        const thisSerializer: Serializer = SerializerBase.hold(createSerializer)
        thisSerializer.writeParseOptions(option)
        getXMLNativeModule()._XML_parse(this.peer, thisSerializer.asArray(), thisSerializer.length());
        thisSerializer.release();
    }
}
