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

import { runtimeType, Tags, RuntimeType, SerializerBase, DeserializerBase, CallbackResource } from "@koalaui/interop"
import { KPointer, InteropNativeModule } from "@koalaui/interop"
import { MaterializedBase } from "@koalaui/interop"
import { int32, float32, unsafeCast } from "@koalaui/common"
import { CallbackKind } from "./CallbackKind"
import { Serializer } from "./Serializer"

import { Finalizable } from "@koalaui/interop"
import { xml } from "./../OHXmlNamespace"

export class Deserializer extends DeserializerBase {
    readXML_Callback_EventType_ParseInfo_Boolean(isSync: boolean = false): ((eventType: xml.EventType, value: xml.ParseInfo) => boolean) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (eventType: xml.EventType, value: xml.ParseInfo): boolean => { 
    const _argsSerializer: Serializer = Serializer.hold();
    _argsSerializer.writeInt32(_resource.resourceId);
    _argsSerializer.writePointer(_call);
    _argsSerializer.writePointer(_callSync);
    _argsSerializer.writeInt32(eventType);
    _argsSerializer.writeParseInfo(value);
    let _continuationValue: boolean | undefined|undefined ;
    const _continuationCallback: ((value: boolean) => void) = (value: boolean): void => {     _continuationValue = value; }
    _argsSerializer.holdAndWriteCallback(_continuationCallback);
    (isSync) ? (InteropNativeModule._CallCallbackSync(240036623, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(240036623, _argsSerializer.asArray(), _argsSerializer.length()));
    _argsSerializer.release();
    return (_continuationValue as boolean); }
    }
    readXML_Callback_String_String_Boolean(isSync: boolean = false): ((name: string, value: string) => boolean) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (name: string, value: string): boolean => { 
    const _argsSerializer: Serializer = Serializer.hold();
    _argsSerializer.writeInt32(_resource.resourceId);
    _argsSerializer.writePointer(_call);
    _argsSerializer.writePointer(_callSync);
    _argsSerializer.writeString(name);
    _argsSerializer.writeString(value);
    let _continuationValue: boolean | undefined|undefined ;
    const _continuationCallback: ((value: boolean) => void) = (value: boolean): void => {     _continuationValue = value; }
    _argsSerializer.holdAndWriteCallback(_continuationCallback);
    (isSync) ? (InteropNativeModule._CallCallbackSync(923368928, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(923368928, _argsSerializer.asArray(), _argsSerializer.length()));
    _argsSerializer.release();
    return (_continuationValue as boolean); }
    }
    readPoint(): xml.Point {
        let valueDeserializer: Deserializer = this
        const x_result: number = (valueDeserializer.readNumber() as number)
        const y_result: number = (valueDeserializer.readNumber() as number)
        let value: xml.Point = ({x: x_result,y: y_result} as xml.Point)
        return value
    }
    readParseOptions(): xml.ParseOptions {
        let valueDeserializer: Deserializer = this
        const supportDoctype_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let supportDoctype_buf: boolean | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (supportDoctype_buf_runtimeType))
        {
            supportDoctype_buf = valueDeserializer.readBoolean()
        }
        const supportDoctype_result: boolean | undefined|undefined = supportDoctype_buf
        const ignoreNameSpace_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let ignoreNameSpace_buf: boolean | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (ignoreNameSpace_buf_runtimeType))
        {
            ignoreNameSpace_buf = valueDeserializer.readBoolean()
        }
        const ignoreNameSpace_result: boolean | undefined|undefined = ignoreNameSpace_buf
        const tagValueCallbackFunction_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let tagValueCallbackFunction_buf: ((name: string, value: string) => boolean) | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (tagValueCallbackFunction_buf_runtimeType))
        {
            tagValueCallbackFunction_buf = valueDeserializer.readXML_Callback_String_String_Boolean()
        }
        const tagValueCallbackFunction_result: ((name: string, value: string) => boolean) | undefined|undefined = tagValueCallbackFunction_buf
        const attributeValueCallbackFunction_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let attributeValueCallbackFunction_buf: ((name: string, value: string) => boolean) | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (attributeValueCallbackFunction_buf_runtimeType))
        {
            attributeValueCallbackFunction_buf = valueDeserializer.readXML_Callback_String_String_Boolean()
        }
        const attributeValueCallbackFunction_result: ((name: string, value: string) => boolean) | undefined|undefined = attributeValueCallbackFunction_buf
        const tokenValueCallbackFunction_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let tokenValueCallbackFunction_buf: ((eventType: xml.EventType, value: xml.ParseInfo) => boolean) | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (tokenValueCallbackFunction_buf_runtimeType))
        {
            tokenValueCallbackFunction_buf = valueDeserializer.readXML_Callback_EventType_ParseInfo_Boolean()
        }
        const tokenValueCallbackFunction_result: ((eventType: xml.EventType, value: xml.ParseInfo) => boolean) | undefined|undefined = tokenValueCallbackFunction_buf
        let value: xml.ParseOptions = ({supportDoctype: supportDoctype_result,ignoreNameSpace: ignoreNameSpace_result,tagValueCallbackFunction: tagValueCallbackFunction_result,attributeValueCallbackFunction: attributeValueCallbackFunction_result,tokenValueCallbackFunction: tokenValueCallbackFunction_result} as xml.ParseOptions)
        return value
    }
    readXML_Callback_Opt_Number_Opt_Array_String_Void(isSync: boolean = false): ((value?: number | undefined, error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value?: number | undefined, error?: Array<string> | undefined): void => { 
    const _argsSerializer: Serializer = Serializer.hold();
    _argsSerializer.writeInt32(_resource.resourceId);
    _argsSerializer.writePointer(_call);
    _argsSerializer.writePointer(_callSync);
    let value_type: int32 = RuntimeType.UNDEFINED;
    value_type = runtimeType(value);
    _argsSerializer.writeInt8(value_type);
    if ((RuntimeType.UNDEFINED) != (value_type)) {
        const value_value = value!;
        _argsSerializer.writeNumber(value_value);
    }
    let error_type: int32 = RuntimeType.UNDEFINED;
    error_type = runtimeType(error);
    _argsSerializer.writeInt8(error_type);
    if ((RuntimeType.UNDEFINED) != (error_type)) {
        const error_value = error!;
        _argsSerializer.writeInt32(error_value.length);
        for (let i = 0; i < error_value.length; i++) {
            const error_value_element: string = error_value[i];
            _argsSerializer.writeString(error_value_element);
        }
    }
    (isSync) ? (InteropNativeModule._CallCallbackSync(1738660608, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(1738660608, _argsSerializer.asArray(), _argsSerializer.length()));
    _argsSerializer.release();
    return; }
    }
    readXML_Callback_Boolean_Void(isSync: boolean = false): ((value: boolean) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value: boolean): void => { 
    const _argsSerializer: Serializer = Serializer.hold();
    _argsSerializer.writeInt32(_resource.resourceId);
    _argsSerializer.writePointer(_call);
    _argsSerializer.writePointer(_callSync);
    _argsSerializer.writeBoolean(value);
    (isSync) ? (InteropNativeModule._CallCallbackSync(313269291, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(313269291, _argsSerializer.asArray(), _argsSerializer.length()));
    _argsSerializer.release();
    return; }
    }
    readXmlPullParser(): xml.XmlPullParser {
        let valueDeserializer: Deserializer = this
        let ptr: KPointer = valueDeserializer.readPointer()
        return xml.XmlPullParserInternal.fromPtr(ptr)
    }
    readParseInfo(): xml.ParseInfo {
        let valueDeserializer: Deserializer = this
        let ptr: KPointer = valueDeserializer.readPointer()
        return xml.ParseInfoInternal.fromPtr(ptr)
    }
    readXmlSerializer(): xml.XmlSerializer {
        let valueDeserializer: Deserializer = this
        let ptr: KPointer = valueDeserializer.readPointer()
        return xml.XmlSerializerInternal.fromPtr(ptr)
    }
}

export function createDeserializer(args: Uint8Array, length: int32): Deserializer { return new Deserializer(args, length) }
