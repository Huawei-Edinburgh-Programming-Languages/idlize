/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { KInt, KBoolean, KFloat, KUInt, KStringPtr, KPointer, KNativePointer, KInt32ArrayPtr, KUint8ArrayPtr, KFloat32ArrayPtr, pointer, KInteropReturnBuffer, NativeBuffer, loadNativeModuleLibrary } from "@koalaui/interop"
import { int32, float32 } from "@koalaui/common"

export class XMLNativeModule {
    static {
        loadNativeModuleLibrary("XMLNativeModule")
    }
    native static _AllocateNativeBuffer(len: int32, data: KUint8ArrayPtr, init: KUint8ArrayPtr): NativeBuffer 
    native static _XmlSerializer_ctor(thisArray: KUint8ArrayPtr, thisLength: int32): KPointer 
    native static _XmlSerializer_getFinalizer(): KPointer 
    native static _XmlSerializer_setAttributes(ptr: KPointer, name: KStringPtr, value: KStringPtr): void 
    native static _XmlSerializer_addEmptyElement(ptr: KPointer, name: KStringPtr): void 
    native static _XmlSerializer_setDeclaration(ptr: KPointer): void 
    native static _XmlSerializer_startElement(ptr: KPointer, name: KStringPtr): void 
    native static _XmlSerializer_endElement(ptr: KPointer): void 
    native static _XmlSerializer_setNamespace(ptr: KPointer, prefix: KStringPtr, namespace_: KStringPtr): void 
    native static _XmlSerializer_setComment(ptr: KPointer, text: KStringPtr): void 
    native static _XmlSerializer_setCDATA(ptr: KPointer, text: KStringPtr): void 
    native static _XmlSerializer_setText(ptr: KPointer, text: KStringPtr): void 
    native static _XmlSerializer_setDocType(ptr: KPointer, text: KStringPtr): void 
    native static _ParseInfo_ctor(): KPointer 
    native static _ParseInfo_getFinalizer(): KPointer 
    native static _ParseInfo_getColumnNumber(ptr: KPointer): number 
    native static _ParseInfo_getDepth(ptr: KPointer): number 
    native static _ParseInfo_getLineNumber(ptr: KPointer): number 
    native static _ParseInfo_getName(ptr: KPointer): string 
    native static _ParseInfo_getNamespace(ptr: KPointer): string 
    native static _ParseInfo_getPrefix(ptr: KPointer): string 
    native static _ParseInfo_getText(ptr: KPointer): string 
    native static _ParseInfo_isEmptyElementTag(ptr: KPointer): boolean 
    native static _ParseInfo_isWhitespace(ptr: KPointer): boolean 
    native static _ParseInfo_getAttributeCount(ptr: KPointer): number 
    native static _XmlPullParser_ctor(thisArray: KUint8ArrayPtr, thisLength: int32): KPointer 
    native static _XmlPullParser_getFinalizer(): KPointer 
    native static _XmlPullParser_parse(ptr: KPointer, thisArray: KUint8ArrayPtr, thisLength: int32): void 
    native static _XmlPullParser_parseXml(ptr: KPointer, thisArray: KUint8ArrayPtr, thisLength: int32): void 
    native static _GlobalScope_xml_xmlpromises_returnPromise(thisArray: KUint8ArrayPtr, thisLength: int32): KPointer 
    native static _GlobalScope_xml_xmlpromises_getPoint(): KInteropReturnBuffer 
}