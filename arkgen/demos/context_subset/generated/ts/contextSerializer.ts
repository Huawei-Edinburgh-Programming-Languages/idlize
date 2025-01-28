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

import { TypeChecker } from "./type_check"
import { Want, StartOptions } from "./context"
import { int32 } from "@koalaui/common"
import { KPointer, KInt, KStringPtr, KUint8ArrayPtr, nullptr, InteropNativeModule, SerializerBase, RuntimeType, runtimeType, CallbackResource, DeserializerBase, wrapSystemCallback, unsafeCast, ResourceHolder } from "@koalaui/interop"
import { CONTEXTNativeModule, CallbackKind } from "./contextNative"
import { Finalizable, MaterializedBase } from "./contextFinalizable"

export class Serializer extends SerializerBase {
    private static pool?: Array<Serializer> | undefined = undefined
    private static poolTop: int32 = -1
    static hold(): Serializer {
        if (!(Serializer.pool != undefined))
        {
            Serializer.pool = new Array<Serializer>(8)
            const pool: Array<Serializer> = (Serializer.pool)!
            for (let idx = 0; idx < 8; idx++) {
                pool[idx] = new Serializer()
            }
        }
        const pool: Array<Serializer> = (Serializer.pool)!
        if (Serializer.poolTop >= pool.length - 1)
        {
            throw new Error("Serializer pool is full. Check if you had released serializers before")
        }
        Serializer.poolTop = Serializer.poolTop + 1
        let serializer = pool[Serializer.poolTop]
        return serializer
    }
    public release(): void {
        if (Serializer.poolTop == -1)
        {
            throw new Error("Serializer pool is empty. Check if you had hold serializers before")
        }
        const pool: Array<Serializer> = (Serializer.pool)!
        if ((this) === (pool[Serializer.poolTop]))
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
        let valueSerializer: Serializer = this
        const value_deviceId = value.deviceId
        let value_deviceId_type: int32 = RuntimeType.UNDEFINED
        value_deviceId_type = runtimeType(value_deviceId)
        valueSerializer.writeInt8(value_deviceId_type)
        if ((RuntimeType.UNDEFINED) != (value_deviceId_type)) {
            const value_deviceId_value = value_deviceId!
            valueSerializer.writeString(value_deviceId_value)
        }
        const value_bundleName = value.bundleName
        let value_bundleName_type: int32 = RuntimeType.UNDEFINED
        value_bundleName_type = runtimeType(value_bundleName)
        valueSerializer.writeInt8(value_bundleName_type)
        if ((RuntimeType.UNDEFINED) != (value_bundleName_type)) {
            const value_bundleName_value = value_bundleName!
            valueSerializer.writeString(value_bundleName_value)
        }
        const value_abilityName = value.abilityName
        let value_abilityName_type: int32 = RuntimeType.UNDEFINED
        value_abilityName_type = runtimeType(value_abilityName)
        valueSerializer.writeInt8(value_abilityName_type)
        if ((RuntimeType.UNDEFINED) != (value_abilityName_type)) {
            const value_abilityName_value = value_abilityName!
            valueSerializer.writeString(value_abilityName_value)
        }
        const value_uri = value.uri
        let value_uri_type: int32 = RuntimeType.UNDEFINED
        value_uri_type = runtimeType(value_uri)
        valueSerializer.writeInt8(value_uri_type)
        if ((RuntimeType.UNDEFINED) != (value_uri_type)) {
            const value_uri_value = value_uri!
            valueSerializer.writeString(value_uri_value)
        }
        const value_type = value.type
        let value_type_type: int32 = RuntimeType.UNDEFINED
        value_type_type = runtimeType(value_type)
        valueSerializer.writeInt8(value_type_type)
        if ((RuntimeType.UNDEFINED) != (value_type_type)) {
            const value_type_value = value_type!
            valueSerializer.writeString(value_type_value)
        }
        const value_flags = value.flags
        let value_flags_type: int32 = RuntimeType.UNDEFINED
        value_flags_type = runtimeType(value_flags)
        valueSerializer.writeInt8(value_flags_type)
        if ((RuntimeType.UNDEFINED) != (value_flags_type)) {
            const value_flags_value = value_flags!
            valueSerializer.writeNumber(value_flags_value)
        }
        const value_action = value.action
        let value_action_type: int32 = RuntimeType.UNDEFINED
        value_action_type = runtimeType(value_action)
        valueSerializer.writeInt8(value_action_type)
        if ((RuntimeType.UNDEFINED) != (value_action_type)) {
            const value_action_value = value_action!
            valueSerializer.writeString(value_action_value)
        }
        const value_parameters = value.parameters
        let value_parameters_type: int32 = RuntimeType.UNDEFINED
        value_parameters_type = runtimeType(value_parameters)
        valueSerializer.writeInt8(value_parameters_type)
        if ((RuntimeType.UNDEFINED) != (value_parameters_type)) {
            const value_parameters_value = value_parameters!
        }
        const value_entities = value.entities
        let value_entities_type: int32 = RuntimeType.UNDEFINED
        value_entities_type = runtimeType(value_entities)
        valueSerializer.writeInt8(value_entities_type)
        if ((RuntimeType.UNDEFINED) != (value_entities_type)) {
            const value_entities_value = value_entities!
            valueSerializer.writeInt32(value_entities_value.length)
            for (let i = 0; i < value_entities_value.length; i++) {
                const value_entities_value_element: string = value_entities_value[i]
                valueSerializer.writeString(value_entities_value_element)
            }
        }
    }
    writeStartOptions(value: StartOptions): void {
        let valueSerializer: Serializer = this
        const value_windowMode = value.windowMode
        let value_windowMode_type: int32 = RuntimeType.UNDEFINED
        value_windowMode_type = runtimeType(value_windowMode)
        valueSerializer.writeInt8(value_windowMode_type)
        if ((RuntimeType.UNDEFINED) != (value_windowMode_type)) {
            const value_windowMode_value = value_windowMode!
            valueSerializer.writeNumber(value_windowMode_value)
        }
        const value_displayId = value.displayId
        let value_displayId_type: int32 = RuntimeType.UNDEFINED
        value_displayId_type = runtimeType(value_displayId)
        valueSerializer.writeInt8(value_displayId_type)
        if ((RuntimeType.UNDEFINED) != (value_displayId_type)) {
            const value_displayId_value = value_displayId!
            valueSerializer.writeNumber(value_displayId_value)
        }
        const value_withAnimation = value.withAnimation
        let value_withAnimation_type: int32 = RuntimeType.UNDEFINED
        value_withAnimation_type = runtimeType(value_withAnimation)
        valueSerializer.writeInt8(value_withAnimation_type)
        if ((RuntimeType.UNDEFINED) != (value_withAnimation_type)) {
            const value_withAnimation_value = value_withAnimation!
            valueSerializer.writeBoolean(value_withAnimation_value)
        }
        const value_windowLeft = value.windowLeft
        let value_windowLeft_type: int32 = RuntimeType.UNDEFINED
        value_windowLeft_type = runtimeType(value_windowLeft)
        valueSerializer.writeInt8(value_windowLeft_type)
        if ((RuntimeType.UNDEFINED) != (value_windowLeft_type)) {
            const value_windowLeft_value = value_windowLeft!
            valueSerializer.writeNumber(value_windowLeft_value)
        }
        const value_windowTop = value.windowTop
        let value_windowTop_type: int32 = RuntimeType.UNDEFINED
        value_windowTop_type = runtimeType(value_windowTop)
        valueSerializer.writeInt8(value_windowTop_type)
        if ((RuntimeType.UNDEFINED) != (value_windowTop_type)) {
            const value_windowTop_value = value_windowTop!
            valueSerializer.writeNumber(value_windowTop_value)
        }
        const value_windowWidth = value.windowWidth
        let value_windowWidth_type: int32 = RuntimeType.UNDEFINED
        value_windowWidth_type = runtimeType(value_windowWidth)
        valueSerializer.writeInt8(value_windowWidth_type)
        if ((RuntimeType.UNDEFINED) != (value_windowWidth_type)) {
            const value_windowWidth_value = value_windowWidth!
            valueSerializer.writeNumber(value_windowWidth_value)
        }
        const value_windowHeight = value.windowHeight
        let value_windowHeight_type: int32 = RuntimeType.UNDEFINED
        value_windowHeight_type = runtimeType(value_windowHeight)
        valueSerializer.writeInt8(value_windowHeight_type)
        if ((RuntimeType.UNDEFINED) != (value_windowHeight_type)) {
            const value_windowHeight_value = value_windowHeight!
            valueSerializer.writeNumber(value_windowHeight_value)
        }
        const value_windowFocused = value.windowFocused
        let value_windowFocused_type: int32 = RuntimeType.UNDEFINED
        value_windowFocused_type = runtimeType(value_windowFocused)
        valueSerializer.writeInt8(value_windowFocused_type)
        if ((RuntimeType.UNDEFINED) != (value_windowFocused_type)) {
            const value_windowFocused_value = value_windowFocused!
            valueSerializer.writeBoolean(value_windowFocused_value)
        }
        const value_processMode = value.processMode
        let value_processMode_type: int32 = RuntimeType.UNDEFINED
        value_processMode_type = runtimeType(value_processMode)
        valueSerializer.writeInt8(value_processMode_type)
        if ((RuntimeType.UNDEFINED) != (value_processMode_type)) {
            const value_processMode_value = value_processMode!
            valueSerializer.writeInt32(value_processMode_value)
        }
        const value_startupVisibility = value.startupVisibility
        let value_startupVisibility_type: int32 = RuntimeType.UNDEFINED
        value_startupVisibility_type = runtimeType(value_startupVisibility)
        valueSerializer.writeInt8(value_startupVisibility_type)
        if ((RuntimeType.UNDEFINED) != (value_startupVisibility_type)) {
            const value_startupVisibility_value = value_startupVisibility!
            valueSerializer.writeInt32(value_startupVisibility_value)
        }
        const value_startWindowIcon = value.startWindowIcon
        let value_startWindowIcon_type: int32 = RuntimeType.UNDEFINED
        value_startWindowIcon_type = runtimeType(value_startWindowIcon)
        valueSerializer.writeInt8(value_startWindowIcon_type)
        if ((RuntimeType.UNDEFINED) != (value_startWindowIcon_type)) {
            const value_startWindowIcon_value = value_startWindowIcon!
            valueSerializer.writeCustomObject("image.PixelMap", value_startWindowIcon_value)
        }
        const value_startWindowBackgroundColor = value.startWindowBackgroundColor
        let value_startWindowBackgroundColor_type: int32 = RuntimeType.UNDEFINED
        value_startWindowBackgroundColor_type = runtimeType(value_startWindowBackgroundColor)
        valueSerializer.writeInt8(value_startWindowBackgroundColor_type)
        if ((RuntimeType.UNDEFINED) != (value_startWindowBackgroundColor_type)) {
            const value_startWindowBackgroundColor_value = value_startWindowBackgroundColor!
            valueSerializer.writeString(value_startWindowBackgroundColor_value)
        }
        const value_supportWindowModes = value.supportWindowModes
        let value_supportWindowModes_type: int32 = RuntimeType.UNDEFINED
        value_supportWindowModes_type = runtimeType(value_supportWindowModes)
        valueSerializer.writeInt8(value_supportWindowModes_type)
        if ((RuntimeType.UNDEFINED) != (value_supportWindowModes_type)) {
            const value_supportWindowModes_value = value_supportWindowModes!
            valueSerializer.writeInt32(value_supportWindowModes_value.length)
            for (let i = 0; i < value_supportWindowModes_value.length; i++) {
                const value_supportWindowModes_value_element: bundleManager.SupportWindowMode = value_supportWindowModes_value[i]
                valueSerializer.writeCustomObject("bundleManager.SupportWindowMode", value_supportWindowModes_value_element)
            }
        }
    }
}

export class Deserializer extends DeserializerBase {
    readWant(): Want {
        let valueDeserializer: Deserializer = this
        const deviceId_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let deviceId_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (deviceId_buf_runtimeType))
        {
            deviceId_buf = (valueDeserializer.readString() as string)
        }
        const deviceId_result: string | undefined|undefined = deviceId_buf
        const bundleName_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let bundleName_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (bundleName_buf_runtimeType))
        {
            bundleName_buf = (valueDeserializer.readString() as string)
        }
        const bundleName_result: string | undefined|undefined = bundleName_buf
        const abilityName_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let abilityName_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (abilityName_buf_runtimeType))
        {
            abilityName_buf = (valueDeserializer.readString() as string)
        }
        const abilityName_result: string | undefined|undefined = abilityName_buf
        const uri_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let uri_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (uri_buf_runtimeType))
        {
            uri_buf = (valueDeserializer.readString() as string)
        }
        const uri_result: string | undefined|undefined = uri_buf
        const type_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let type_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (type_buf_runtimeType))
        {
            type_buf = (valueDeserializer.readString() as string)
        }
        const type_result: string | undefined|undefined = type_buf
        const flags_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let flags_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (flags_buf_runtimeType))
        {
            flags_buf = (valueDeserializer.readNumber() as number)
        }
        const flags_result: number | undefined|undefined = flags_buf
        const action_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let action_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (action_buf_runtimeType))
        {
            action_buf = (valueDeserializer.readString() as string)
        }
        const action_result: string | undefined|undefined = action_buf
        const parameters_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let parameters_buf: {  } | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (parameters_buf_runtimeType))
        {
            parameters_buf = ({} as {  })
        }
        const parameters_result: {  } | undefined|undefined = parameters_buf
        const entities_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let entities_buf: Array<string> | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (entities_buf_runtimeType))
        {
            const entities_buf__length: int32 = valueDeserializer.readInt32()
            let entities_buf_: Array<string> = new Array<string>()
            for (let entities_buf__i = 0; entities_buf__i < entities_buf__length; entities_buf__i++) {
                entities_buf_[entities_buf__i] = (valueDeserializer.readString() as string)
            }
            entities_buf = entities_buf_
        }
        const entities_result: Array<string> | undefined|undefined = entities_buf
        let value: Want = ({deviceId: deviceId_result,bundleName: bundleName_result,abilityName: abilityName_result,uri: uri_result,type: type_result,flags: flags_result,action: action_result,parameters: parameters_result,entities: entities_result} as Want)
        return value
    }
    readCONTEXT_AsyncCallback_Void(isSync: boolean = false): (() => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); (isSync) ? (InteropNativeModule._CallCallbackSync(1075219926, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(1075219926, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_AsyncCallback_dialogRequest_RequestResult_Void(isSync: boolean = false): ((result: dialogRequest.RequestResult) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (result: dialogRequest.RequestResult): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); _argsSerializer.writeCustomObject("dialogRequest.RequestResult", result); (isSync) ? (InteropNativeModule._CallCallbackSync(-1652909257, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-1652909257, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readStartOptions(): StartOptions {
        let valueDeserializer: Deserializer = this
        const windowMode_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let windowMode_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (windowMode_buf_runtimeType))
        {
            windowMode_buf = (valueDeserializer.readNumber() as number)
        }
        const windowMode_result: number | undefined|undefined = windowMode_buf
        const displayId_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let displayId_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (displayId_buf_runtimeType))
        {
            displayId_buf = (valueDeserializer.readNumber() as number)
        }
        const displayId_result: number | undefined|undefined = displayId_buf
        const withAnimation_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let withAnimation_buf: boolean | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (withAnimation_buf_runtimeType))
        {
            withAnimation_buf = valueDeserializer.readBoolean()
        }
        const withAnimation_result: boolean | undefined|undefined = withAnimation_buf
        const windowLeft_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let windowLeft_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (windowLeft_buf_runtimeType))
        {
            windowLeft_buf = (valueDeserializer.readNumber() as number)
        }
        const windowLeft_result: number | undefined|undefined = windowLeft_buf
        const windowTop_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let windowTop_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (windowTop_buf_runtimeType))
        {
            windowTop_buf = (valueDeserializer.readNumber() as number)
        }
        const windowTop_result: number | undefined|undefined = windowTop_buf
        const windowWidth_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let windowWidth_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (windowWidth_buf_runtimeType))
        {
            windowWidth_buf = (valueDeserializer.readNumber() as number)
        }
        const windowWidth_result: number | undefined|undefined = windowWidth_buf
        const windowHeight_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let windowHeight_buf: number | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (windowHeight_buf_runtimeType))
        {
            windowHeight_buf = (valueDeserializer.readNumber() as number)
        }
        const windowHeight_result: number | undefined|undefined = windowHeight_buf
        const windowFocused_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let windowFocused_buf: boolean | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (windowFocused_buf_runtimeType))
        {
            windowFocused_buf = valueDeserializer.readBoolean()
        }
        const windowFocused_result: boolean | undefined|undefined = windowFocused_buf
        const processMode_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let processMode_buf: contextConstant.ProcessMode | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (processMode_buf_runtimeType))
        {
            processMode_buf = (valueDeserializer.readInt32() as contextConstant.ProcessMode)
        }
        const processMode_result: contextConstant.ProcessMode | undefined|undefined = processMode_buf
        const startupVisibility_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let startupVisibility_buf: contextConstant.StartupVisibility | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (startupVisibility_buf_runtimeType))
        {
            startupVisibility_buf = (valueDeserializer.readInt32() as contextConstant.StartupVisibility)
        }
        const startupVisibility_result: contextConstant.StartupVisibility | undefined|undefined = startupVisibility_buf
        const startWindowIcon_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let startWindowIcon_buf: image.PixelMap | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (startWindowIcon_buf_runtimeType))
        {
            startWindowIcon_buf = (valueDeserializer.readCustomObject("image.PixelMap") as image.PixelMap)
        }
        const startWindowIcon_result: image.PixelMap | undefined|undefined = startWindowIcon_buf
        const startWindowBackgroundColor_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let startWindowBackgroundColor_buf: string | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (startWindowBackgroundColor_buf_runtimeType))
        {
            startWindowBackgroundColor_buf = (valueDeserializer.readString() as string)
        }
        const startWindowBackgroundColor_result: string | undefined|undefined = startWindowBackgroundColor_buf
        const supportWindowModes_buf_runtimeType = (valueDeserializer.readInt8() as int32)
        let supportWindowModes_buf: Array<bundleManager.SupportWindowMode> | undefined|undefined 
        if ((RuntimeType.UNDEFINED) != (supportWindowModes_buf_runtimeType))
        {
            const supportWindowModes_buf__length: int32 = valueDeserializer.readInt32()
            let supportWindowModes_buf_: Array<bundleManager.SupportWindowMode> = new Array<bundleManager.SupportWindowMode>()
            for (let supportWindowModes_buf__i = 0; supportWindowModes_buf__i < supportWindowModes_buf__length; supportWindowModes_buf__i++) {
                supportWindowModes_buf_[supportWindowModes_buf__i] = (valueDeserializer.readCustomObject("bundleManager.SupportWindowMode") as bundleManager.SupportWindowMode)
            }
            supportWindowModes_buf = supportWindowModes_buf_
        }
        const supportWindowModes_result: Array<bundleManager.SupportWindowMode> | undefined|undefined = supportWindowModes_buf
        let value: StartOptions = ({windowMode: windowMode_result,displayId: displayId_result,withAnimation: withAnimation_result,windowLeft: windowLeft_result,windowTop: windowTop_result,windowWidth: windowWidth_result,windowHeight: windowHeight_result,windowFocused: windowFocused_result,processMode: processMode_result,startupVisibility: startupVisibility_result,startWindowIcon: startWindowIcon_result,startWindowBackgroundColor: startWindowBackgroundColor_result,supportWindowModes: supportWindowModes_result} as StartOptions)
        return value
    }
    readCONTEXT_AsyncCallback_AbilityResult_Void(isSync: boolean = false): ((result: AbilityResult) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (result: AbilityResult): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); _argsSerializer.writeCustomObject("AbilityResult", result); (isSync) ? (InteropNativeModule._CallCallbackSync(1801791970, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(1801791970, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_AsyncCallback_String_Void(isSync: boolean = false): ((result: string) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (result: string): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); _argsSerializer.writeString(result); (isSync) ? (InteropNativeModule._CallCallbackSync(789188988, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(789188988, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Void(isSync: boolean = false): (() => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); (isSync) ? (InteropNativeModule._CallCallbackSync(-1867723152, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-1867723152, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void(isSync: boolean = false): ((value?: UIServiceProxy | undefined, error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value?: UIServiceProxy | undefined, error?: Array<string> | undefined): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); let value_type: int32 = RuntimeType.UNDEFINED; value_type = runtimeType(value); _argsSerializer.writeInt8(value_type); if ((RuntimeType.UNDEFINED) != (value_type)) {; const value_value = value!; _argsSerializer.writeCustomObject("UIServiceProxy", value_value); } let error_type: int32 = RuntimeType.UNDEFINED; error_type = runtimeType(error); _argsSerializer.writeInt8(error_type); if ((RuntimeType.UNDEFINED) != (error_type)) {; const error_value = error!; _argsSerializer.writeInt32(error_value.length); for (let i = 0; i < error_value.length; i++) {; const error_value_element: string = error_value[i]; _argsSerializer.writeString(error_value_element); } } (isSync) ? (InteropNativeModule._CallCallbackSync(-1175461650, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-1175461650, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Opt_String_Opt_Array_String_Void(isSync: boolean = false): ((value?: string | undefined, error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value?: string | undefined, error?: Array<string> | undefined): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); let value_type: int32 = RuntimeType.UNDEFINED; value_type = runtimeType(value); _argsSerializer.writeInt8(value_type); if ((RuntimeType.UNDEFINED) != (value_type)) {; const value_value = value!; _argsSerializer.writeString(value_value); } let error_type: int32 = RuntimeType.UNDEFINED; error_type = runtimeType(error); _argsSerializer.writeInt8(error_type); if ((RuntimeType.UNDEFINED) != (error_type)) {; const error_value = error!; _argsSerializer.writeInt32(error_value.length); for (let i = 0; i < error_value.length; i++) {; const error_value_element: string = error_value[i]; _argsSerializer.writeString(error_value_element); } } (isSync) ? (InteropNativeModule._CallCallbackSync(1813490422, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(1813490422, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(isSync: boolean = false): ((value?: dialogRequest.RequestResult | undefined, error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value?: dialogRequest.RequestResult | undefined, error?: Array<string> | undefined): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); let value_type: int32 = RuntimeType.UNDEFINED; value_type = runtimeType(value); _argsSerializer.writeInt8(value_type); if ((RuntimeType.UNDEFINED) != (value_type)) {; const value_value = value!; _argsSerializer.writeCustomObject("dialogRequest.RequestResult", value_value); } let error_type: int32 = RuntimeType.UNDEFINED; error_type = runtimeType(error); _argsSerializer.writeInt8(error_type); if ((RuntimeType.UNDEFINED) != (error_type)) {; const error_value = error!; _argsSerializer.writeInt32(error_value.length); for (let i = 0; i < error_value.length; i++) {; const error_value_element: string = error_value[i]; _argsSerializer.writeString(error_value_element); } } (isSync) ? (InteropNativeModule._CallCallbackSync(1663507741, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(1663507741, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Opt_Caller_Opt_Array_String_Void(isSync: boolean = false): ((value?: Caller | undefined, error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value?: Caller | undefined, error?: Array<string> | undefined): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); let value_type: int32 = RuntimeType.UNDEFINED; value_type = runtimeType(value); _argsSerializer.writeInt8(value_type); if ((RuntimeType.UNDEFINED) != (value_type)) {; const value_value = value!; _argsSerializer.writeCustomObject("Caller", value_value); } let error_type: int32 = RuntimeType.UNDEFINED; error_type = runtimeType(error); _argsSerializer.writeInt8(error_type); if ((RuntimeType.UNDEFINED) != (error_type)) {; const error_value = error!; _argsSerializer.writeInt32(error_value.length); for (let i = 0; i < error_value.length; i++) {; const error_value_element: string = error_value[i]; _argsSerializer.writeString(error_value_element); } } (isSync) ? (InteropNativeModule._CallCallbackSync(-701632170, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-701632170, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Opt_Array_String_Void(isSync: boolean = false): ((error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (error?: Array<string> | undefined): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); let error_type: int32 = RuntimeType.UNDEFINED; error_type = runtimeType(error); _argsSerializer.writeInt8(error_type); if ((RuntimeType.UNDEFINED) != (error_type)) {; const error_value = error!; _argsSerializer.writeInt32(error_value.length); for (let i = 0; i < error_value.length; i++) {; const error_value_element: string = error_value[i]; _argsSerializer.writeString(error_value_element); } } (isSync) ? (InteropNativeModule._CallCallbackSync(-543655128, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(-543655128, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
    readCONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void(isSync: boolean = false): ((value?: AbilityResult | undefined, error?: Array<string> | undefined) => void) {
        const _resource: CallbackResource = this.readCallbackResource()
        const _call: KPointer = this.readPointer()
        const _callSync: KPointer = this.readPointer()
        return (value?: AbilityResult | undefined, error?: Array<string> | undefined): void => { const _argsSerializer: Serializer = Serializer.hold(); _argsSerializer.writeInt32(_resource.resourceId); _argsSerializer.writePointer(_call); _argsSerializer.writePointer(_callSync); let value_type: int32 = RuntimeType.UNDEFINED; value_type = runtimeType(value); _argsSerializer.writeInt8(value_type); if ((RuntimeType.UNDEFINED) != (value_type)) {; const value_value = value!; _argsSerializer.writeCustomObject("AbilityResult", value_value); } let error_type: int32 = RuntimeType.UNDEFINED; error_type = runtimeType(error); _argsSerializer.writeInt8(error_type); if ((RuntimeType.UNDEFINED) != (error_type)) {; const error_value = error!; _argsSerializer.writeInt32(error_value.length); for (let i = 0; i < error_value.length; i++) {; const error_value_element: string = error_value[i]; _argsSerializer.writeString(error_value_element); } } (isSync) ? (InteropNativeModule._CallCallbackSync(2092467560, _argsSerializer.asArray(), _argsSerializer.length())) : (InteropNativeModule._CallCallback(2092467560, _argsSerializer.asArray(), _argsSerializer.length())); _argsSerializer.release(); return; }
    }
}
export function deserializeAndCallAsyncCallback_AbilityResult_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((result: AbilityResult) => void))
    let result: AbilityResult = (thisDeserializer.readCustomObject("AbilityResult") as AbilityResult)
    _call(result)
}
export function deserializeAndCallAsyncCallback_dialogRequest_RequestResult_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((result: dialogRequest.RequestResult) => void))
    let result: dialogRequest.RequestResult = (thisDeserializer.readCustomObject("dialogRequest.RequestResult") as dialogRequest.RequestResult)
    _call(result)
}
export function deserializeAndCallAsyncCallback_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((result: string) => void))
    let result: string = (thisDeserializer.readString() as string)
    _call(result)
}
export function deserializeAndCallAsyncCallback_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as (() => void))
    _call()
}
export function deserializeAndCallCallback_Opt_AbilityResult_Opt_Array_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((value?: AbilityResult | undefined, error?: Array<string> | undefined) => void))
    const value_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let value_buf: AbilityResult | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf = (thisDeserializer.readCustomObject("AbilityResult") as AbilityResult)
    }
    let value: AbilityResult | undefined|undefined = value_buf
    const error_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let error_buf: Array<string> | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length: int32 = thisDeserializer.readInt32()
        let error_buf_: Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error: Array<string> | undefined|undefined = error_buf
    _call(value, error)
}
export function deserializeAndCallCallback_Opt_Array_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((error?: Array<string> | undefined) => void))
    const error_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let error_buf: Array<string> | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length: int32 = thisDeserializer.readInt32()
        let error_buf_: Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error: Array<string> | undefined|undefined = error_buf
    _call(error)
}
export function deserializeAndCallCallback_Opt_Caller_Opt_Array_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((value?: Caller | undefined, error?: Array<string> | undefined) => void))
    const value_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let value_buf: Caller | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf = (thisDeserializer.readCustomObject("Caller") as Caller)
    }
    let value: Caller | undefined|undefined = value_buf
    const error_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let error_buf: Array<string> | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length: int32 = thisDeserializer.readInt32()
        let error_buf_: Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error: Array<string> | undefined|undefined = error_buf
    _call(value, error)
}
export function deserializeAndCallCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((value?: dialogRequest.RequestResult | undefined, error?: Array<string> | undefined) => void))
    const value_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let value_buf: dialogRequest.RequestResult | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf = (thisDeserializer.readCustomObject("dialogRequest.RequestResult") as dialogRequest.RequestResult)
    }
    let value: dialogRequest.RequestResult | undefined|undefined = value_buf
    const error_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let error_buf: Array<string> | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length: int32 = thisDeserializer.readInt32()
        let error_buf_: Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error: Array<string> | undefined|undefined = error_buf
    _call(value, error)
}
export function deserializeAndCallCallback_Opt_String_Opt_Array_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((value?: string | undefined, error?: Array<string> | undefined) => void))
    const value_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let value_buf: string | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf = (thisDeserializer.readString() as string)
    }
    let value: string | undefined|undefined = value_buf
    const error_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let error_buf: Array<string> | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length: int32 = thisDeserializer.readInt32()
        let error_buf_: Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error: Array<string> | undefined|undefined = error_buf
    _call(value, error)
}
export function deserializeAndCallCallback_Opt_UIServiceProxy_Opt_Array_String_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as ((value?: UIServiceProxy | undefined, error?: Array<string> | undefined) => void))
    const value_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let value_buf: UIServiceProxy | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf = (thisDeserializer.readCustomObject("UIServiceProxy") as UIServiceProxy)
    }
    let value: UIServiceProxy | undefined|undefined = value_buf
    const error_buf_runtimeType = (thisDeserializer.readInt8() as int32)
    let error_buf: Array<string> | undefined|undefined 
    if ((RuntimeType.UNDEFINED) != (error_buf_runtimeType))
    {
        const error_buf__length: int32 = thisDeserializer.readInt32()
        let error_buf_: Array<string> = new Array<string>()
        for (let error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_[error_buf__i] = (thisDeserializer.readString() as string)
        }
        error_buf = error_buf_
    }
    let error: Array<string> | undefined|undefined = error_buf
    _call(value, error)
}
export function deserializeAndCallCallback_Void(thisDeserializer: Deserializer) {
    const _resourceId: int32 = thisDeserializer.readInt32()
    const _call = (ResourceHolder.instance().get(_resourceId) as (() => void))
    _call()
}
export function deserializeAndCallCallback(thisDeserializer: Deserializer) {
    const kind: int32 = thisDeserializer.readInt32()
    switch (kind) {
        case 1801791970/*CallbackKind.Kind_AsyncCallback_AbilityResult_Void*/: return deserializeAndCallAsyncCallback_AbilityResult_Void(thisDeserializer);
        case -1652909257/*CallbackKind.Kind_AsyncCallback_dialogRequest_RequestResult_Void*/: return deserializeAndCallAsyncCallback_dialogRequest_RequestResult_Void(thisDeserializer);
        case 789188988/*CallbackKind.Kind_AsyncCallback_String_Void*/: return deserializeAndCallAsyncCallback_String_Void(thisDeserializer);
        case 1075219926/*CallbackKind.Kind_AsyncCallback_Void*/: return deserializeAndCallAsyncCallback_Void(thisDeserializer);
        case 2092467560/*CallbackKind.Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_AbilityResult_Opt_Array_String_Void(thisDeserializer);
        case -543655128/*CallbackKind.Kind_Callback_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Array_String_Void(thisDeserializer);
        case -701632170/*CallbackKind.Kind_Callback_Opt_Caller_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Caller_Opt_Array_String_Void(thisDeserializer);
        case 1663507741/*CallbackKind.Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(thisDeserializer);
        case 1813490422/*CallbackKind.Kind_Callback_Opt_String_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_String_Opt_Array_String_Void(thisDeserializer);
        case -1175461650/*CallbackKind.Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_UIServiceProxy_Opt_Array_String_Void(thisDeserializer);
        case -1867723152/*CallbackKind.Kind_Callback_Void*/: return deserializeAndCallCallback_Void(thisDeserializer);
    }
    throw new Error("Unknown callback kind")
}
wrapSystemCallback(1, (buff:Uint8Array, len:int32) => { deserializeAndCallCallback(new Deserializer(buff.buffer, len)); return 0 })