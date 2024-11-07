import { pointer, int32, EventType, KPointer } from "./types"

export enum CallbackKind {
    Kind_Callback_Boolean_Void = 0,
    Kind_Callback_EventType_ParseInfo_Boolean = 1,
    Kind_Callback_String_String_Boolean = 2,
    Kind_Callback_Void = 3
}
export interface XMLNativeModule {
    _XML_setAttributes(self: KPointer, name: string, value: string): void 
    _XML_addEmptyElement(self: KPointer, name: string): void 
    _XML_setDeclaration(self: KPointer): void 
    _XML_startElement(self: KPointer, name: string): void 
    _XML_endElement(self: KPointer): void 
    _XML_setNamespace(self: KPointer, prefix: string, namespace: string): void 
    _XML_setComment(self: KPointer, text: string): void 
    _XML_setCDATA(self: KPointer, text: string): void 
    _XML_setText(self: KPointer, text: string): void 
    _XML_setDocType(self: KPointer, text: string): void 
    _XML_getColumnNumber(self: KPointer): number 
    _XML_getDepth(self: KPointer): number 
    _XML_getLineNumber(self: KPointer): number 
    _XML_getName(self: KPointer): string 
    _XML_getNamespace(self: KPointer): string 
    _XML_getPrefix(self: KPointer): string 
    _XML_getText(self: KPointer): string 
    _XML_isEmptyElementTag(self: KPointer): boolean 
    _XML_isWhitespace(self: KPointer): boolean 
    _XML_getAttributeCount(self: KPointer): number 
    _XML_parse(self: KPointer, thisArray: Uint8Array, thisLength: int32): void 
    _XmlSerializer_ctor(buffer: ArrayBuffer | DataView, encoding: string): KPointer 
    _ParseInfo_ctor(): KPointer 
    _XmlPullParser_ctor(buffer: ArrayBuffer | DataView, encoding: string): KPointer 
    _GetManagerCallbackCaller(kind: CallbackKind): KPointer 
}

type NativeModuleType = XMLNativeModule
let theModule: NativeModuleType | undefined = undefined

declare const LOAD_NATIVE: NativeModuleType

export function getXMLNativeModule(): NativeModuleType {
    if (theModule) return theModule
    theModule = LOAD_NATIVE as NativeModuleType
    if (!theModule)
        throw new Error("Cannot load native module")
    return theModule
}

