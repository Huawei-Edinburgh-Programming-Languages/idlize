import { pointer, int32, EventType, KPointer } from "./types"
import { SerializerBase } from "./SerializerBase"
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
        this.peer = getXMLNativeModule()._XmlSerializer_ctor(buffer, encoding)
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
        return getXMLNativeModule()._XML_getColumnNumber(this.peer)
    }
    getDepth(): number {
        return getXMLNativeModule()._XML_getDepth(this.peer)
    }
    getLineNumber(): number {
        return getXMLNativeModule()._XML_getLineNumber(this.peer)
    }
    getName(): string {
        return getXMLNativeModule()._XML_getName(this.peer)
    }
    getNamespace(): string {
        return getXMLNativeModule()._XML_getNamespace(this.peer)
    }
    getPrefix(): string {
        return getXMLNativeModule()._XML_getPrefix(this.peer)
    }
    getText(): string {
        return getXMLNativeModule()._XML_getText(this.peer)
    }
    isEmptyElementTag(): boolean {
        return getXMLNativeModule()._XML_isEmptyElementTag(this.peer)
    }
    isWhitespace(): boolean {
        return getXMLNativeModule()._XML_isWhitespace(this.peer)
    }
    getAttributeCount(): number {
        return getXMLNativeModule()._XML_getAttributeCount(this.peer)
    }
}
export class XmlPullParser implements XmlPullParserInterface {
    private peer: KPointer
     constructor(buffer: ArrayBuffer | DataView, encoding: string) {
        this.peer = getXMLNativeModule()._XmlPullParser_ctor(buffer, encoding)
    }
    parse(option: ParseOptions): void {
        const thisSerializer: Serializer = SerializerBase.hold(createSerializer)
        thisSerializer.writeParseOptions(option)
        getXMLNativeModule()._XML_parse(this.peer, thisSerializer.asArray(), thisSerializer.length());
        thisSerializer.release();
    }
}
