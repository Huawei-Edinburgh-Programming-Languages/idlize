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

import { SerializerBase, Tags, RuntimeType, runtimeType, isResource, isInstanceOf, MaterializedBase, nullptr, KPointer } from "@koalaui/interop"
import { int32, float32, unsafeCast, int64 } from "@koalaui/common"
import { TypeChecker } from "#components"
import { KUint8ArrayPtr, NativeBuffer, InteropNativeModule } from "@koalaui/interop"
import { xml_EventType, xml } from "./../OHXmlNamespace"
export class Serializer extends SerializerBase {
    private static pool?: Array<Serializer> | undefined = undefined
    private static poolTop: int32 = -1
    static hold(): Serializer {
        if (!(Serializer.pool != undefined))
        {
            Serializer.pool = new Array<Serializer>(8)
            const pool : Array<Serializer> = (Serializer.pool)!
            for (let idx = 0; idx < 8; idx++) {
                pool[idx] = new Serializer()
            }
        }
        const pool : Array<Serializer> = (Serializer.pool)!
        if (Serializer.poolTop >= pool.length - 1)
        {
            throw new Error("Serializer pool is full. Check if you had released serializers before")
        }
        Serializer.poolTop = Serializer.poolTop + 1
        let serializer  = pool[Serializer.poolTop]
        return serializer
    }
    public release(): void {
        if (Serializer.poolTop == -1)
        {
            throw new Error("Serializer pool is empty. Check if you had hold serializers before")
        }
        const pool : Array<Serializer> = (Serializer.pool)!
        if ((this) == (pool[Serializer.poolTop]))
        {
            Serializer.poolTop = Serializer.poolTop - 1
            super.release()
            return
        }
        throw new Error("Only last serializer should be released")
    }
     constructor() {
        super()
    }
    writeParseOptions(value: xml.ParseOptions): void {
        let valueSerializer : Serializer = this
        const value_supportDoctype  = value.supportDoctype
        let value_supportDoctype_type : int32 = RuntimeType.UNDEFINED
        value_supportDoctype_type = runtimeType(value_supportDoctype)
        valueSerializer.writeInt8(value_supportDoctype_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_supportDoctype_type)) {
            const value_supportDoctype_value  = value_supportDoctype!
            valueSerializer.writeBoolean(value_supportDoctype_value)
        }
        const value_ignoreNameSpace  = value.ignoreNameSpace
        let value_ignoreNameSpace_type : int32 = RuntimeType.UNDEFINED
        value_ignoreNameSpace_type = runtimeType(value_ignoreNameSpace)
        valueSerializer.writeInt8(value_ignoreNameSpace_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_ignoreNameSpace_type)) {
            const value_ignoreNameSpace_value  = value_ignoreNameSpace!
            valueSerializer.writeBoolean(value_ignoreNameSpace_value)
        }
        const value_tagValueCallbackFunction  = value.tagValueCallbackFunction
        let value_tagValueCallbackFunction_type : int32 = RuntimeType.UNDEFINED
        value_tagValueCallbackFunction_type = runtimeType(value_tagValueCallbackFunction)
        valueSerializer.writeInt8(value_tagValueCallbackFunction_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_tagValueCallbackFunction_type)) {
            const value_tagValueCallbackFunction_value  = value_tagValueCallbackFunction!
            valueSerializer.holdAndWriteCallback(value_tagValueCallbackFunction_value)
        }
        const value_attributeValueCallbackFunction  = value.attributeValueCallbackFunction
        let value_attributeValueCallbackFunction_type : int32 = RuntimeType.UNDEFINED
        value_attributeValueCallbackFunction_type = runtimeType(value_attributeValueCallbackFunction)
        valueSerializer.writeInt8(value_attributeValueCallbackFunction_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_attributeValueCallbackFunction_type)) {
            const value_attributeValueCallbackFunction_value  = value_attributeValueCallbackFunction!
            valueSerializer.holdAndWriteCallback(value_attributeValueCallbackFunction_value)
        }
        const value_tokenValueCallbackFunction  = value.tokenValueCallbackFunction
        let value_tokenValueCallbackFunction_type : int32 = RuntimeType.UNDEFINED
        value_tokenValueCallbackFunction_type = runtimeType(value_tokenValueCallbackFunction)
        valueSerializer.writeInt8(value_tokenValueCallbackFunction_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_tokenValueCallbackFunction_type)) {
            const value_tokenValueCallbackFunction_value  = value_tokenValueCallbackFunction!
            valueSerializer.holdAndWriteCallback(value_tokenValueCallbackFunction_value)
        }
    }
    writeXmlPullParser(value: xml.XmlPullParser): void {
        let valueSerializer : Serializer = this
        if (TypeChecker.typeInstanceOf<MaterializedBase>(value, "peer"))
        {
            const base : MaterializedBase = TypeChecker.typeCast<MaterializedBase>(value)
            const peer  = base.getPeer()
            let ptr : KPointer = nullptr
            if (peer != undefined)
                ptr = peer.ptr
            valueSerializer.writePointer(ptr)
            return
        }
        else
        {
            throw new Error("Value is not a MaterializedBase instance!")
        }
    }
    writeParseInfo(value: xml.ParseInfo): void {
        let valueSerializer : Serializer = this
        if (TypeChecker.typeInstanceOf<MaterializedBase>(value, "peer"))
        {
            const base : MaterializedBase = TypeChecker.typeCast<MaterializedBase>(value)
            const peer  = base.getPeer()
            let ptr : KPointer = nullptr
            if (peer != undefined)
                ptr = peer.ptr
            valueSerializer.writePointer(ptr)
            return
        }
        else
        {
            throw new Error("Value is not a MaterializedBase instance!")
        }
    }
    writeXmlSerializer(value: xml.XmlSerializer): void {
        let valueSerializer : Serializer = this
        if (TypeChecker.typeInstanceOf<MaterializedBase>(value, "peer"))
        {
            const base : MaterializedBase = TypeChecker.typeCast<MaterializedBase>(value)
            const peer  = base.getPeer()
            let ptr : KPointer = nullptr
            if (peer != undefined)
                ptr = peer.ptr
            valueSerializer.writePointer(ptr)
            return
        }
        else
        {
            throw new Error("Value is not a MaterializedBase instance!")
        }
    }
}