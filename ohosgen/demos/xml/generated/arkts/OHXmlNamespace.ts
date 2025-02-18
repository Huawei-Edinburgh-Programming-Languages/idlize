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


// WARNING! THIS FILE IS AUTO-GENERATED, DO NOT MAKE CHANGES, THEY WILL BE LOST ON NEXT GENERATION!

import { TypeChecker } from "#components"
import { Finalizable, isResource, isInstanceOf, runtimeType, RuntimeType, SerializerBase, registerCallback, wrapCallback, KPointer, MaterializedBase, NativeBuffer } from "@koalaui/interop"
import { unsafeCast, int32, float32 } from "@koalaui/common"
import { Serializer } from "./peers/Serializer"
import { CallbackKind } from "./peers/CallbackKind"
import { Deserializer } from "./peers/Deserializer"
import { XMLNativeModule } from "./XMLNativeModule"
export namespace xml {
    export class XmlSerializerInternal {
        public static fromPtr(ptr: KPointer): XmlSerializer {
            const obj : XmlSerializer = new XmlSerializer(undefined, undefined)
            obj.peer = new Finalizable(ptr, XmlSerializer.getFinalizer())
            return obj
        }
    }
    export class XmlSerializer implements MaterializedBase {
        peer?: Finalizable | undefined
        public getPeer(): Finalizable | undefined {
            return this.peer
        }
        static ctor_xmlserializer(buffer: NativeBuffer, encoding?: string): KPointer {
            const thisSerializer : Serializer = Serializer.hold()
            thisSerializer.writeBuffer(buffer)
            let encoding_type : int32 = RuntimeType.UNDEFINED
            encoding_type = runtimeType(encoding)
            thisSerializer.writeInt8(encoding_type as int32)
            if ((RuntimeType.UNDEFINED) != (encoding_type)) {
                const encoding_value  = encoding!
                thisSerializer.writeString(encoding_value)
            }
            const retval  = XMLNativeModule._XmlSerializer_ctor(thisSerializer.asArray(), thisSerializer.length())
            thisSerializer.release()
            return retval
        }
         constructor(buffer?: NativeBuffer, encoding?: string) {
            if (((buffer) !== (undefined)) && ((encoding) !== (undefined)))
            {
                const ctorPtr : KPointer = XmlSerializer.ctor_xmlserializer(buffer, encoding)
                this.peer = new Finalizable(ctorPtr, XmlSerializer.getFinalizer())
            }
        }
        static getFinalizer(): KPointer {
            return XMLNativeModule._XmlSerializer_getFinalizer()
        }
        public setAttributes(name: string, value: string): void {
            const name_casted = name as (string)
            const value_casted = value as (string)
            this.setAttributes_serialize(name_casted, value_casted)
            return
        }
        public addEmptyElement(name: string): void {
            const name_casted = name as (string)
            this.addEmptyElement_serialize(name_casted)
            return
        }
        public setDeclaration(): void {
            this.setDeclaration_serialize()
            return
        }
        public startElement(name: string): void {
            const name_casted = name as (string)
            this.startElement_serialize(name_casted)
            return
        }
        public endElement(): void {
            this.endElement_serialize()
            return
        }
        public setNamespace(prefix: string, namespace_: string): void {
            const prefix_casted = prefix as (string)
            const namespace_casted = namespace_ as (string)
            this.setNamespace_serialize(prefix_casted, namespace_casted)
            return
        }
        public setComment(text: string): void {
            const text_casted = text as (string)
            this.setComment_serialize(text_casted)
            return
        }
        public setCDATA(text: string): void {
            const text_casted = text as (string)
            this.setCDATA_serialize(text_casted)
            return
        }
        public setText(text: string): void {
            const text_casted = text as (string)
            this.setText_serialize(text_casted)
            return
        }
        public setDocType(text: string): void {
            const text_casted = text as (string)
            this.setDocType_serialize(text_casted)
            return
        }
        private setAttributes_serialize(name: string, value: string): void {
            XMLNativeModule._XmlSerializer_setAttributes(this.peer!.ptr, name, value)
        }
        private addEmptyElement_serialize(name: string): void {
            XMLNativeModule._XmlSerializer_addEmptyElement(this.peer!.ptr, name)
        }
        private setDeclaration_serialize(): void {
            XMLNativeModule._XmlSerializer_setDeclaration(this.peer!.ptr)
        }
        private startElement_serialize(name: string): void {
            XMLNativeModule._XmlSerializer_startElement(this.peer!.ptr, name)
        }
        private endElement_serialize(): void {
            XMLNativeModule._XmlSerializer_endElement(this.peer!.ptr)
        }
        private setNamespace_serialize(prefix: string, namespace_: string): void {
            XMLNativeModule._XmlSerializer_setNamespace(this.peer!.ptr, prefix, namespace_)
        }
        private setComment_serialize(text: string): void {
            XMLNativeModule._XmlSerializer_setComment(this.peer!.ptr, text)
        }
        private setCDATA_serialize(text: string): void {
            XMLNativeModule._XmlSerializer_setCDATA(this.peer!.ptr, text)
        }
        private setText_serialize(text: string): void {
            XMLNativeModule._XmlSerializer_setText(this.peer!.ptr, text)
        }
        private setDocType_serialize(text: string): void {
            XMLNativeModule._XmlSerializer_setDocType(this.peer!.ptr, text)
        }
    }
}
export namespace xml {
    export class ParseInfoInternal implements MaterializedBase,ParseInfo {
        peer?: Finalizable | undefined
        public getPeer(): Finalizable | undefined {
            return this.peer
        }
        static ctor_parseinfo(): KPointer {
            const retval  = XMLNativeModule._ParseInfo_ctor()
            return retval
        }
         constructor() {
            const ctorPtr : KPointer = ParseInfoInternal.ctor_parseinfo()
            this.peer = new Finalizable(ctorPtr, ParseInfoInternal.getFinalizer())
        }
        static getFinalizer(): KPointer {
            return XMLNativeModule._ParseInfo_getFinalizer()
        }
        public getColumnNumber(): number {
            return this.getColumnNumber_serialize()
        }
        public getDepth(): number {
            return this.getDepth_serialize()
        }
        public getLineNumber(): number {
            return this.getLineNumber_serialize()
        }
        public getName(): string {
            return this.getName_serialize()
        }
        public getNamespace(): string {
            return this.getNamespace_serialize()
        }
        public getPrefix(): string {
            return this.getPrefix_serialize()
        }
        public getText(): string {
            return this.getText_serialize()
        }
        public isEmptyElementTag(): boolean {
            return this.isEmptyElementTag_serialize()
        }
        public isWhitespace(): boolean {
            return this.isWhitespace_serialize()
        }
        public getAttributeCount(): number {
            return this.getAttributeCount_serialize()
        }
        private getColumnNumber_serialize(): number {
            const retval  = XMLNativeModule._ParseInfo_getColumnNumber(this.peer!.ptr)
            return retval
        }
        private getDepth_serialize(): number {
            const retval  = XMLNativeModule._ParseInfo_getDepth(this.peer!.ptr)
            return retval
        }
        private getLineNumber_serialize(): number {
            const retval  = XMLNativeModule._ParseInfo_getLineNumber(this.peer!.ptr)
            return retval
        }
        private getName_serialize(): string {
            const retval  = XMLNativeModule._ParseInfo_getName(this.peer!.ptr)
            return retval
        }
        private getNamespace_serialize(): string {
            const retval  = XMLNativeModule._ParseInfo_getNamespace(this.peer!.ptr)
            return retval
        }
        private getPrefix_serialize(): string {
            const retval  = XMLNativeModule._ParseInfo_getPrefix(this.peer!.ptr)
            return retval
        }
        private getText_serialize(): string {
            const retval  = XMLNativeModule._ParseInfo_getText(this.peer!.ptr)
            return retval
        }
        private isEmptyElementTag_serialize(): boolean {
            const retval  = XMLNativeModule._ParseInfo_isEmptyElementTag(this.peer!.ptr)
            return retval
        }
        private isWhitespace_serialize(): boolean {
            const retval  = XMLNativeModule._ParseInfo_isWhitespace(this.peer!.ptr)
            return retval
        }
        private getAttributeCount_serialize(): number {
            const retval  = XMLNativeModule._ParseInfo_getAttributeCount(this.peer!.ptr)
            return retval
        }
        public static fromPtr(ptr: KPointer): ParseInfoInternal {
            const obj : ParseInfoInternal = new ParseInfoInternal()
            obj.peer = new Finalizable(ptr, ParseInfoInternal.getFinalizer())
            return obj
        }
    }
}
export namespace xml {
    export class XmlPullParserInternal {
        public static fromPtr(ptr: KPointer): XmlPullParser {
            const obj : XmlPullParser = new XmlPullParser(undefined, undefined)
            obj.peer = new Finalizable(ptr, XmlPullParser.getFinalizer())
            return obj
        }
    }
    export class XmlPullParser implements MaterializedBase {
        peer?: Finalizable | undefined
        public getPeer(): Finalizable | undefined {
            return this.peer
        }
        static ctor_xmlpullparser(buffer: NativeBuffer, encoding?: string): KPointer {
            const thisSerializer : Serializer = Serializer.hold()
            thisSerializer.writeBuffer(buffer)
            let encoding_type : int32 = RuntimeType.UNDEFINED
            encoding_type = runtimeType(encoding)
            thisSerializer.writeInt8(encoding_type as int32)
            if ((RuntimeType.UNDEFINED) != (encoding_type)) {
                const encoding_value  = encoding!
                thisSerializer.writeString(encoding_value)
            }
            const retval  = XMLNativeModule._XmlPullParser_ctor(thisSerializer.asArray(), thisSerializer.length())
            thisSerializer.release()
            return retval
        }
         constructor(buffer?: NativeBuffer, encoding?: string) {
            if (((buffer) !== (undefined)) && ((encoding) !== (undefined)))
            {
                const ctorPtr : KPointer = XmlPullParser.ctor_xmlpullparser(buffer, encoding)
                this.peer = new Finalizable(ctorPtr, XmlPullParser.getFinalizer())
            }
        }
        static getFinalizer(): KPointer {
            return XMLNativeModule._XmlPullParser_getFinalizer()
        }
        public parse(option: xml.ParseOptions): void {
            const option_casted = option as (xml.ParseOptions)
            this.parse_serialize(option_casted)
            return
        }
        public parseXml(option: xml.ParseOptions): void {
            const option_casted = option as (xml.ParseOptions)
            this.parseXml_serialize(option_casted)
            return
        }
        private parse_serialize(option: xml.ParseOptions): void {
            const thisSerializer : Serializer = Serializer.hold()
            thisSerializer.writeParseOptions(option)
            XMLNativeModule._XmlPullParser_parse(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
            thisSerializer.release()
        }
        private parseXml_serialize(option: xml.ParseOptions): void {
            const thisSerializer : Serializer = Serializer.hold()
            thisSerializer.writeParseOptions(option)
            XMLNativeModule._XmlPullParser_parseXml(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
            thisSerializer.release()
        }
    }
}
export enum xml_EventType {
    START_DOCUMENT = 0,
    END_DOCUMENT = 1,
    START_TAG = 2,
    END_TAG = 3,
    TEXT = 4,
    CDSECT = 5,
    COMMENT = 6,
    DOCDECL = 7,
    INSTRUCTION = 8,
    ENTITY_REFERENCE = 9,
    WHITESPACE = 10
}
export namespace xml {
    export interface ParseInfo {
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
}
export namespace xml {
    export interface ParseOptions {
        supportDoctype?: boolean
        ignoreNameSpace?: boolean
        tagValueCallbackFunction?: ((name: string,value: string) => boolean)
        attributeValueCallbackFunction?: ((name: string,value: string) => boolean)
        tokenValueCallbackFunction?: ((eventType: xml_EventType,value: xml.ParseInfo) => boolean)
    }
}
