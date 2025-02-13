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

// import { Want, UIAbilityContext, UIAbilityContextInternal } from "./uiabilitycontext"
import { TypeChecker } from "./type_check"
import { int32, float32 } from "@koalaui/common"
import { KPointer, KInt, KStringPtr, KUint8ArrayPtr, nullptr, InteropNativeModule, SerializerBase, RuntimeType, runtimeType, CallbackResource, DeserializerBase, wrapSystemCallback, Finalizable, ResourceHolder } from "@koalaui/interop"
import { UIAbilityContextNativeModule, CallbackKind } from "./uiabilitycontextNative"
// import { MaterializedBase } from "./xmlFinalizable"
import { Want } from "./@ohos.app.ability.Want"
import { UIAbilityContext, UIAbilityContextInternal } from "./UIAbilityContext"
import { MaterializedBase } from "./uiabilitycontextFinalizable"

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
    writeWant(value: Want): void {
        let valueSerializer : Serializer = this
        const value_bundleName  = value.bundleName
        let value_bundleName_type : int32 = RuntimeType.UNDEFINED
        value_bundleName_type = runtimeType(value_bundleName)
        valueSerializer.writeInt8(value_bundleName_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_bundleName_type)) {
            const value_bundleName_value  = value_bundleName!
            valueSerializer.writeString(value_bundleName_value)
        }
        const value_abilityName  = value.abilityName
        let value_abilityName_type : int32 = RuntimeType.UNDEFINED
        value_abilityName_type = runtimeType(value_abilityName)
        valueSerializer.writeInt8(value_abilityName_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_abilityName_type)) {
            const value_abilityName_value  = value_abilityName!
            valueSerializer.writeString(value_abilityName_value)
        }
        const value_deviceId  = value.deviceId
        let value_deviceId_type : int32 = RuntimeType.UNDEFINED
        value_deviceId_type = runtimeType(value_deviceId)
        valueSerializer.writeInt8(value_deviceId_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_deviceId_type)) {
            const value_deviceId_value  = value_deviceId!
            valueSerializer.writeString(value_deviceId_value)
        }
        const value_uri  = value.uri
        let value_uri_type : int32 = RuntimeType.UNDEFINED
        value_uri_type = runtimeType(value_uri)
        valueSerializer.writeInt8(value_uri_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_uri_type)) {
            const value_uri_value  = value_uri!
            valueSerializer.writeString(value_uri_value)
        }
        const value_type  = value.type
        let value_type_type : int32 = RuntimeType.UNDEFINED
        value_type_type = runtimeType(value_type)
        valueSerializer.writeInt8(value_type_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_type_type)) {
            const value_type_value  = value_type!
            valueSerializer.writeString(value_type_value)
        }
        const value_flags  = value.flags
        let value_flags_type : int32 = RuntimeType.UNDEFINED
        value_flags_type = runtimeType(value_flags)
        valueSerializer.writeInt8(value_flags_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_flags_type)) {
            const value_flags_value  = value_flags!
            valueSerializer.writeNumber(value_flags_value)
        }
        const value_action  = value.action
        let value_action_type : int32 = RuntimeType.UNDEFINED
        value_action_type = runtimeType(value_action)
        valueSerializer.writeInt8(value_action_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_action_type)) {
            const value_action_value  = value_action!
            valueSerializer.writeString(value_action_value)
        }
        const value_parameters  = value.parameters
        let value_parameters_type : int32 = RuntimeType.UNDEFINED
        value_parameters_type = runtimeType(value_parameters)
        valueSerializer.writeInt8(value_parameters_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_parameters_type)) {
            const value_parameters_value  = value_parameters!
            valueSerializer.writeInt32(value_parameters_value.size as int32)
            // TODO: map serialization not implemented
        }
        const value_entities  = value.entities
        let value_entities_type : int32 = RuntimeType.UNDEFINED
        value_entities_type = runtimeType(value_entities)
        valueSerializer.writeInt8(value_entities_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_entities_type)) {
            const value_entities_value  = value_entities!
            valueSerializer.writeInt32(value_entities_value.length as int32)
            for (let i = 0; i < value_entities_value.length; i++) {
                const value_entities_value_element : string = value_entities_value[i]
                valueSerializer.writeString(value_entities_value_element)
            }
        }
        const value_moduleName  = value.moduleName
        let value_moduleName_type : int32 = RuntimeType.UNDEFINED
        value_moduleName_type = runtimeType(value_moduleName)
        valueSerializer.writeInt8(value_moduleName_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_moduleName_type)) {
            const value_moduleName_value  = value_moduleName!
            valueSerializer.writeString(value_moduleName_value)
        }
        const value_fds  = value.fds
        let value_fds_type : int32 = RuntimeType.UNDEFINED
        value_fds_type = runtimeType(value_fds)
        valueSerializer.writeInt8(value_fds_type as int32)
        if ((RuntimeType.UNDEFINED) != (value_fds_type)) {
            const value_fds_value  = value_fds!
            valueSerializer.writeInt32(value_fds_value.size as int32)
            // TODO: map serialization not implemented
        }
    }
    writeUIAbilityContext(value: UIAbilityContext): void {
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

export class Deserializer extends DeserializerBase {
     constructor(data: KUint8ArrayPtr, length: int32) {
        super(data, length)
    }
    readUIAbilityContext_AsyncCallback_Void(isSync: boolean = false): (() => void) {
        const _resource : CallbackResource = this.readCallbackResource()
        const _call : KPointer = this.readPointer()
        const _callSync : KPointer = this.readPointer()
        return ():void => { const _argsSerializer : Serializer = Serializer.hold();
_argsSerializer.writeInt32(_resource.resourceId);
_argsSerializer.writePointer(_call);
_argsSerializer.writePointer(_callSync);
(isSync) ? (InteropNativeModule._CallCallbackSync(1075219926, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(1075219926, _argsSerializer.asArray(), _argsSerializer.length()));
_argsSerializer.release();
return; }
    }
    readWant(): Want {
        let valueDeserializer : Deserializer = this
        const bundleName_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let bundleName_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (bundleName_buf_runtimeType))
        {
            bundleName_buf = (valueDeserializer.readString() as string)
        }
        const bundleName_result : string | undefined = bundleName_buf
        const abilityName_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let abilityName_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (abilityName_buf_runtimeType))
        {
            abilityName_buf = (valueDeserializer.readString() as string)
        }
        const abilityName_result : string | undefined = abilityName_buf
        const deviceId_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let deviceId_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (deviceId_buf_runtimeType))
        {
            deviceId_buf = (valueDeserializer.readString() as string)
        }
        const deviceId_result : string | undefined = deviceId_buf
        const uri_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let uri_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (uri_buf_runtimeType))
        {
            uri_buf = (valueDeserializer.readString() as string)
        }
        const uri_result : string | undefined = uri_buf
        const type_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let type_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (type_buf_runtimeType))
        {
            type_buf = (valueDeserializer.readString() as string)
        }
        const type_result : string | undefined = type_buf
        const flags_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let flags_buf : number | undefined
        if ((RuntimeType.UNDEFINED) != (flags_buf_runtimeType))
        {
            flags_buf = (valueDeserializer.readNumber() as number)
        }
        const flags_result : number | undefined = flags_buf
        const action_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let action_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (action_buf_runtimeType))
        {
            action_buf = (valueDeserializer.readString() as string)
        }
        const action_result : string | undefined = action_buf
        const parameters_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let parameters_buf : Map<string, Object> | undefined
        if ((RuntimeType.UNDEFINED) != (parameters_buf_runtimeType))
        {
            const parameters_buf__size : int32 = valueDeserializer.readInt32()
            let parameters_buf_ : Map<string, Object> = new Map<string, Object>()
            // TODO: TS map resize
            for (let parameters_buf__i = 0; parameters_buf__i < parameters_buf__size; parameters_buf__i++) {
                const parameters_buf__key : string = (valueDeserializer.readString() as string)
                const parameters_buf__value : Object = (valueDeserializer.readCustomObject("Object") as Object)
                parameters_buf_.set(parameters_buf__key, parameters_buf__value)
            }
            parameters_buf = parameters_buf_
        }
        const parameters_result : Map<string, Object> | undefined = parameters_buf
        const entities_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let entities_buf : Array<string> | undefined
        if ((RuntimeType.UNDEFINED) != (entities_buf_runtimeType))
        {
            const entities_buf__length : int32 = valueDeserializer.readInt32()
            let entities_buf_ : Array<string> = new Array<string>()
            for (let entities_buf__i = 0; entities_buf__i < entities_buf__length; entities_buf__i++) {
                entities_buf_[entities_buf__i] = (valueDeserializer.readString() as string)
            }
            entities_buf = entities_buf_
        }
        const entities_result : Array<string> | undefined = entities_buf
        const moduleName_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let moduleName_buf : string | undefined
        if ((RuntimeType.UNDEFINED) != (moduleName_buf_runtimeType))
        {
            moduleName_buf = (valueDeserializer.readString() as string)
        }
        const moduleName_result : string | undefined = moduleName_buf
        const fds_buf_runtimeType  = (valueDeserializer.readInt8() as int32)
        let fds_buf : Map<string, number> | undefined
        if ((RuntimeType.UNDEFINED) != (fds_buf_runtimeType))
        {
            const fds_buf__size : int32 = valueDeserializer.readInt32()
            let fds_buf_ : Map<string, number> = new Map<string, number>()
            // TODO: TS map resize
            for (let fds_buf__i = 0; fds_buf__i < fds_buf__size; fds_buf__i++) {
                const fds_buf__key : string = (valueDeserializer.readString() as string)
                const fds_buf__value : number = (valueDeserializer.readNumber() as number)
                fds_buf_.set(fds_buf__key, fds_buf__value)
            }
            fds_buf = fds_buf_
        }
        const fds_result : Map<string, number> | undefined = fds_buf
        let value : Want = ({bundleName: bundleName_result,abilityName: abilityName_result,deviceId: deviceId_result,uri: uri_result,type: type_result,flags: flags_result,action: action_result,parameters: parameters_result,entities: entities_result,moduleName: moduleName_result,fds: fds_result} as Want)
        return value
    }
    readUIAbilityContext_Callback_Void(isSync: boolean = false): (() => void) {
        const _resource : CallbackResource = this.readCallbackResource()
        const _call : KPointer = this.readPointer()
        const _callSync : KPointer = this.readPointer()
        return ():void => { const _argsSerializer : Serializer = Serializer.hold();
_argsSerializer.writeInt32(_resource.resourceId);
_argsSerializer.writePointer(_call);
_argsSerializer.writePointer(_callSync);
(isSync) ? (InteropNativeModule._CallCallbackSync(-1867723152, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-1867723152, _argsSerializer.asArray(), _argsSerializer.length()));
_argsSerializer.release();
return; }
    }
    readUIAbilityContext_Callback_Opt_Array_String_Void(isSync: boolean = false): ((error?: Array<string> | undefined) => void) {
        const _resource : CallbackResource = this.readCallbackResource()
        const _call : KPointer = this.readPointer()
        const _callSync : KPointer = this.readPointer()
        return (error?: Array<string> | undefined):void => { const _argsSerializer : Serializer = Serializer.hold();
_argsSerializer.writeInt32(_resource.resourceId);
_argsSerializer.writePointer(_call);
_argsSerializer.writePointer(_callSync);
let error_type : int32 = RuntimeType.UNDEFINED;
error_type = runtimeType(error);
_argsSerializer.writeInt8(error_type as int32);
if ((RuntimeType.UNDEFINED) != (error_type)) {
    const error_value  = error!;
    _argsSerializer.writeInt32(error_value.length as int32);
    for (let i = 0; i < error_value.length; i++) {
        const error_value_element : string = error_value[i];
        _argsSerializer.writeString(error_value_element);
    }
}
(isSync) ? (InteropNativeModule._CallCallbackSync(-543655128, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-543655128, _argsSerializer.asArray(), _argsSerializer.length()));
_argsSerializer.release();
return; }
    }
    readUIAbilityContext(): UIAbilityContext {
        let valueDeserializer : Deserializer = this
        let ptr : KPointer = valueDeserializer.readPointer()
        return UIAbilityContextInternal.fromPtr(ptr)
    }
}
export function deserializeAndCallAsyncCallback_Void(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as (() => void))
    _call()
}
export function deserializeAndCallCallback_Opt_Array_String_Void(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as ((error?: Array<string> | undefined) => void))
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
    _call(error)
}
export function deserializeAndCallCallback_Void(thisDeserializer: Deserializer): void {
    const _resourceId : int32 = thisDeserializer.readInt32()
    const _call  = (ResourceHolder.instance().get(_resourceId) as (() => void))
    _call()
}
export function deserializeAndCallCallback(thisDeserializer: Deserializer): void {
    const kind : int32 = thisDeserializer.readInt32()
    switch (kind) {
        case 1075219926/*CallbackKind.Kind_AsyncCallback_Void*/: return deserializeAndCallAsyncCallback_Void(thisDeserializer);
        case -543655128/*CallbackKind.Kind_Callback_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Array_String_Void(thisDeserializer);
        case -1867723152/*CallbackKind.Kind_Callback_Void*/: return deserializeAndCallCallback_Void(thisDeserializer);
    }
    console.log("Unknown callback kind")
}