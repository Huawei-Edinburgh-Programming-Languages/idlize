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

import { KInt, KBoolean, KFloat, KUInt, KStringPtr, KPointer, KNativePointer, KInt32ArrayPtr, KUint8ArrayPtr, KFloat32ArrayPtr, pointer, KInteropReturnBuffer, loadNativeModuleLibrary } from "@koalaui/interop"
import { int32, float32 } from "@koalaui/common"

export class XMLNativeModule {
    private static _isLoaded: boolean = false
    private static _LoadOnce(): boolean {
        if ((this._isLoaded) == (false))
        {
            this._isLoaded = true
            loadNativeModuleLibrary("XMLNativeModule", XMLNativeModule)
            return true
        }
        return false
    }
    static _XmlSerializer_ctor(thisArray: Uint8Array, thisLength: int32): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_ctor(thisArray, thisLength)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_getFinalizer(): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_getFinalizer()
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setAttributes(ptr: KPointer, name: KStringPtr, value: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setAttributes(ptr, name, value)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_addEmptyElement(ptr: KPointer, name: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_addEmptyElement(ptr, name)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setDeclaration(ptr: KPointer): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setDeclaration(ptr)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_startElement(ptr: KPointer, name: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_startElement(ptr, name)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_endElement(ptr: KPointer): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_endElement(ptr)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setNamespace(ptr: KPointer, prefix: KStringPtr, namespace_: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setNamespace(ptr, prefix, namespace_)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setComment(ptr: KPointer, text: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setComment(ptr, text)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setCDATA(ptr: KPointer, text: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setCDATA(ptr, text)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setText(ptr: KPointer, text: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setText(ptr, text)
        }
        throw new Error("Not implemented")
    }
    static _XmlSerializer_setDocType(ptr: KPointer, text: KStringPtr): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlSerializer_setDocType(ptr, text)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_ctor(): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_ctor()
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getFinalizer(): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getFinalizer()
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getColumnNumber(ptr: KPointer): number {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getColumnNumber(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getDepth(ptr: KPointer): number {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getDepth(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getLineNumber(ptr: KPointer): number {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getLineNumber(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getName(ptr: KPointer): string {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getName(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getNamespace(ptr: KPointer): string {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getNamespace(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getPrefix(ptr: KPointer): string {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getPrefix(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getText(ptr: KPointer): string {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getText(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_isEmptyElementTag(ptr: KPointer): boolean {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_isEmptyElementTag(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_isWhitespace(ptr: KPointer): boolean {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_isWhitespace(ptr)
        }
        throw new Error("Not implemented")
    }
    static _ParseInfo_getAttributeCount(ptr: KPointer): number {
        if ((this._LoadOnce()) == (true))
        {
            return this._ParseInfo_getAttributeCount(ptr)
        }
        throw new Error("Not implemented")
    }
    static _XmlPullParser_ctor(thisArray: Uint8Array, thisLength: int32): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlPullParser_ctor(thisArray, thisLength)
        }
        throw new Error("Not implemented")
    }
    static _XmlPullParser_getFinalizer(): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlPullParser_getFinalizer()
        }
        throw new Error("Not implemented")
    }
    static _XmlPullParser_parse(ptr: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlPullParser_parse(ptr, thisArray, thisLength)
        }
        throw new Error("Not implemented")
    }
    static _XmlPullParser_parseXml(ptr: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        if ((this._LoadOnce()) == (true))
        {
            return this._XmlPullParser_parseXml(ptr, thisArray, thisLength)
        }
        throw new Error("Not implemented")
    }
    static _GlobalScope_xml_xmlpromises_returnPromise(thisArray: Uint8Array, thisLength: int32): KPointer {
        if ((this._LoadOnce()) == (true))
        {
            return this._GlobalScope_xml_xmlpromises_returnPromise(thisArray, thisLength)
        }
        throw new Error("Not implemented")
    }
    static _GlobalScope_xml_xmlpromises_getPoint(): KInteropReturnBuffer {
        if ((this._LoadOnce()) == (true))
        {
            return this._GlobalScope_xml_xmlpromises_getPoint()
        }
        throw new Error("Not implemented")
    }
}