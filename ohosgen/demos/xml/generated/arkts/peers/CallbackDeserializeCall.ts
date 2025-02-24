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

import { CallbackKind } from "./CallbackKind"
import { Deserializer } from "./Deserializer"
import { int32, float32, int64 } from "@koalaui/common"
import { ResourceHolder, KInt, KStringPtr, wrapSystemCallback, KPointer, RuntimeType } from "@koalaui/interop"
import { xml } from "./../OHXmlNamespace"

export function deserializeAndCallCallback_Boolean_Void(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as ((value: boolean) => void))
    let value : boolean = thisDeserializer.readBoolean()
    _call(value)
}
export function deserializeAndCallCallback_EventType_ParseInfo_Boolean(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as ((eventType: xml.EventType,value: xml.ParseInfo) => boolean))
    let eventType : xml.EventType = (thisDeserializer.readInt32() as xml.EventType)
    let value : xml.ParseInfo = (thisDeserializer.readParseInfo() as xml.ParseInfo)
    let _continuation : ((value: boolean) => void) = thisDeserializer.readXML_Callback_Boolean_Void(true)
    const _callResult  = _call(eventType, value)
    _continuation(_callResult)
}
export function deserializeAndCallCallback_Opt_Number_Opt_Array_String_Void(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as ((value?: number | undefined,error?: Array<string> | undefined) => void))
    const value_buf_runtimeType  = (thisDeserializer.readInt8() as int32)
    let value_buf : number | undefined
    if ((RuntimeType.UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf = (thisDeserializer.readNumber() as number)
    }
    let value : number | undefined = value_buf
    const error_buf_runtimeType  = (thisDeserializer.readInt8() as int32)
    let error_buf : Array<string> | undefined
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length : int32 = thisDeserializer.readInt32()
        let error_buf_ : Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error : Array<string> | undefined = error_buf
    _call(value, error)
}
export function deserializeAndCallCallback_String_String_Boolean(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as ((name: string,value: string) => boolean))
    let name : string = (thisDeserializer.readString() as string)
    let value : string = (thisDeserializer.readString() as string)
    let _continuation : ((value: boolean) => void) = thisDeserializer.readXML_Callback_Boolean_Void(true)
    const _callResult  = _call(name, value)
    _continuation(_callResult)
}
export function deserializeAndCallCallback(thisDeserializer: Deserializer): void {
    const kind : int32 = thisDeserializer.readInt32()
    switch (kind) {
        case 313269291/*CallbackKind.Kind_Callback_Boolean_Void*/: return deserializeAndCallCallback_Boolean_Void(thisDeserializer);
        case 240036623/*CallbackKind.Kind_Callback_EventType_ParseInfo_Boolean*/: return deserializeAndCallCallback_EventType_ParseInfo_Boolean(thisDeserializer);
        case 1738660608/*CallbackKind.Kind_Callback_Opt_Number_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Number_Opt_Array_String_Void(thisDeserializer);
        case 923368928/*CallbackKind.Kind_Callback_String_String_Boolean*/: return deserializeAndCallCallback_String_String_Boolean(thisDeserializer);
    }
    console.log("Unknown callback kind")
}