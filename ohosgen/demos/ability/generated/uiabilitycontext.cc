/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

#include "uiabilitycontext.h"

#define KOALA_INTEROP_MODULE UIAbilityContextNativeModule
#include "common-interop.h"
#include "callback-resource.h"
#include "SerializerBase.h"
#include "DeserializerBase.h"
#include <unordered_map>

#if KOALA_USE_PANDA_VM
KOALA_ETS_INTEROP_MODULE_CLASSPATH(KOALA_INTEROP_MODULE, KOALA_QUOTE(ETS_MODULE_CLASSPATH_PREFIX) KOALA_QUOTE(KOALA_INTEROP_MODULE));
#endif

CustomDeserializer * DeserializerBase::customDeserializers = nullptr;

typedef enum CallbackKind {
    Kind_AsyncCallback_Void = 1075219926,
    Kind_Callback_Opt_Array_String_Void = -543655128,
    Kind_Callback_Void = -1867723152,
} CallbackKind;

OH_NativePointer getManagedCallbackCaller(CallbackKind kind);
OH_NativePointer getManagedCallbackCallerSync(CallbackKind kind);

struct Counter {
    int count;
    void* data;
};

static int bufferResourceId = 0;
static std::unordered_map<int, Counter> refCounterMap;

int allocate_buffer(int len, void** mem) {
    char* data = new char[len];
    (*mem) = data;
    int id = ++bufferResourceId;
    refCounterMap[id] = Counter { 1, (void*)data };
    return id;
}

void releaseBuffer(int resourceId) {
    if (refCounterMap.find(resourceId) != refCounterMap.end()) {
        Counter& record = refCounterMap[resourceId];
        --record.count;
        if (record.count <= 0) {
            delete[] (char*)record.data;
        }
    }
}

void holdBuffer(int resourceId) {
    if (refCounterMap.find(resourceId) != refCounterMap.end()) {
        Counter& record = refCounterMap[resourceId];
        ++record.count;
    }
}

void impl_AllocateNativeBuffer(KInt len, KByte* ret, KByte* init) {
    void* mem;
    int resourceId = allocate_buffer(len, &mem);
    memcpy((KByte*)mem, init, len);
    SerializerBase ser { ret, 40 }; // todo check
    ser.writeInt32(resourceId);
    ser.writePointer((void*)&holdBuffer);
    ser.writePointer((void*)&releaseBuffer);
    ser.writePointer(mem);
    ser.writeInt64(len);

}
KOALA_INTEROP_V3(AllocateNativeBuffer, KInt, KByte*, KByte*);
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const OH_Int32& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const Opt_Int32* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_Int32& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Map_String_Number& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_String* value);
template <>
inline void WriteToString(std::string* result, const OH_Number* value);
template <>
inline void WriteToString(std::string* result, const Map_String_Number* value) {
    result->append("{");
    int32_t count = value->size;
    for (int i = 0; i < count; i++) {
        if (i > 0) result->append(", ");
        WriteToString(result, (const OH_String*)&value->keys[i]);
        result->append(": ");
        WriteToString(result, (const OH_Number*)&value->values[i]);
    }
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_Map_String_Number* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_Map_String_Number& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const OH_String& value)
{
    return INTEROP_RUNTIME_STRING;
}
template <>
inline void WriteToString(std::string* result, const Opt_String* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_String& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Array_String& value)
{
    return INTEROP_RUNTIME_OBJECT;
}

template <>
inline void WriteToString(std::string* result, const OH_String* value);

inline void WriteToString(std::string* result, const Array_String* value) {
    int32_t count = value->length;
    result->append("{.array=allocArray<OH_String, " + std::to_string(count) + ">({{");
    for (int i = 0; i < count; i++) {
        if (i > 0) result->append(", ");
        WriteToString(result, (const OH_String*)&value->array[i]);
    }
    result->append("}})");
    result->append(", .length=");
    result->append(std::to_string(value->length));
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_Array_String* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_Array_String& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Map_String_CustomObject& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_String* value);
template <>
inline void WriteToString(std::string* result, const OH_CustomObject* value);
template <>
inline void WriteToString(std::string* result, const Map_String_CustomObject* value) {
    result->append("{");
    int32_t count = value->size;
    for (int i = 0; i < count; i++) {
        if (i > 0) result->append(", ");
        WriteToString(result, (const OH_String*)&value->keys[i]);
        result->append(": ");
        WriteToString(result, (const OH_CustomObject*)&value->values[i]);
    }
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_Map_String_CustomObject* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_Map_String_CustomObject& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const OH_Number& value)
{
    return INTEROP_RUNTIME_NUMBER;
}
template <>
inline void WriteToString(std::string* result, const Opt_Number* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_Number& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const UIAbilityContext_AsyncCallback_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const UIAbilityContext_AsyncCallback_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_UIAbilityContext_AsyncCallback_Void* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_UIAbilityContext_AsyncCallback_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const OH_UIAbilityContext_Want& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_UIAbilityContext_Want* value) {
    result->append("{");
    // OH_String bundleName
    result->append(".bundleName=");
    WriteToString(result, &value->bundleName);
    // OH_String abilityName
    result->append(", ");
    result->append(".abilityName=");
    WriteToString(result, &value->abilityName);
    // OH_String deviceId
    result->append(", ");
    result->append(".deviceId=");
    WriteToString(result, &value->deviceId);
    // OH_String uri
    result->append(", ");
    result->append(".uri=");
    WriteToString(result, &value->uri);
    // OH_String type
    result->append(", ");
    result->append(".type=");
    WriteToString(result, &value->type);
    // OH_Number flags
    result->append(", ");
    result->append(".flags=");
    WriteToString(result, &value->flags);
    // OH_String action
    result->append(", ");
    result->append(".action=");
    WriteToString(result, &value->action);
    // Map_String_CustomObject parameters
    result->append(", ");
    result->append(".parameters=");
    WriteToString(result, &value->parameters);
    // Array_String entities
    result->append(", ");
    result->append(".entities=");
    WriteToString(result, &value->entities);
    // OH_String moduleName
    result->append(", ");
    result->append(".moduleName=");
    WriteToString(result, &value->moduleName);
    // Map_String_Number fds
    result->append(", ");
    result->append(".fds=");
    WriteToString(result, &value->fds);
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_Want* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_Want& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const UIAbilityContext_Callback_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const UIAbilityContext_Callback_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_UIAbilityContext_Callback_Void* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_UIAbilityContext_Callback_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const UIAbilityContext_Callback_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const UIAbilityContext_Callback_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_UIAbilityContext_Callback_Opt_Array_String_Void* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_UIAbilityContext_Callback_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline void WriteToString(std::string* result, const Opt_CustomObject* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, &value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_CustomObject& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const OH_UIAbilityContext_UIAbilityContext& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_UIAbilityContext_UIAbilityContext value) {
    WriteToString(result, static_cast<InteropNativePointer>(value));
}
template <>
inline void WriteToString(std::string* result, const Opt_UIAbilityContext* value) {
    result->append("{.tag=");
    result->append(tagNameExact((OH_Tag)(value->tag)));
    result->append(", .value=");
    if (value->tag != INTEROP_TAG_UNDEFINED) {
        WriteToString(result, value->value);
    } else {
        OH_Undefined undefined = { 0 };
        WriteToString(result, undefined);
    }
    result->append("}");
}
template <>
inline OH_UIAbilityContext_RuntimeType runtimeType(const Opt_UIAbilityContext& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
class Serializer : public SerializerBase {
    public:
    Serializer(uint8_t* data, OH_UInt32 dataLength = 0, CallbackResourceHolder* resourceHolder = nullptr) : SerializerBase(data, dataLength, resourceHolder) {
    }
    void writeWant(OH_UIAbilityContext_Want value)
    {
        Serializer& valueSerializer = *this;
        const auto value_bundleName = value.bundleName;
        OH_Int32 value_bundleName_type = INTEROP_RUNTIME_UNDEFINED;
        value_bundleName_type = runtimeType(value_bundleName);
        valueSerializer.writeInt8(value_bundleName_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_bundleName_type)) {
            const auto value_bundleName_value = value_bundleName.value;
            valueSerializer.writeString(value_bundleName_value);
        }
        const auto value_abilityName = value.abilityName;
        OH_Int32 value_abilityName_type = INTEROP_RUNTIME_UNDEFINED;
        value_abilityName_type = runtimeType(value_abilityName);
        valueSerializer.writeInt8(value_abilityName_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_abilityName_type)) {
            const auto value_abilityName_value = value_abilityName.value;
            valueSerializer.writeString(value_abilityName_value);
        }
        const auto value_deviceId = value.deviceId;
        OH_Int32 value_deviceId_type = INTEROP_RUNTIME_UNDEFINED;
        value_deviceId_type = runtimeType(value_deviceId);
        valueSerializer.writeInt8(value_deviceId_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_deviceId_type)) {
            const auto value_deviceId_value = value_deviceId.value;
            valueSerializer.writeString(value_deviceId_value);
        }
        const auto value_uri = value.uri;
        OH_Int32 value_uri_type = INTEROP_RUNTIME_UNDEFINED;
        value_uri_type = runtimeType(value_uri);
        valueSerializer.writeInt8(value_uri_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_uri_type)) {
            const auto value_uri_value = value_uri.value;
            valueSerializer.writeString(value_uri_value);
        }
        const auto value_type = value.type;
        OH_Int32 value_type_type = INTEROP_RUNTIME_UNDEFINED;
        value_type_type = runtimeType(value_type);
        valueSerializer.writeInt8(value_type_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_type_type)) {
            const auto value_type_value = value_type.value;
            valueSerializer.writeString(value_type_value);
        }
        const auto value_flags = value.flags;
        OH_Int32 value_flags_type = INTEROP_RUNTIME_UNDEFINED;
        value_flags_type = runtimeType(value_flags);
        valueSerializer.writeInt8(value_flags_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_flags_type)) {
            const auto value_flags_value = value_flags.value;
            valueSerializer.writeNumber(value_flags_value);
        }
        const auto value_action = value.action;
        OH_Int32 value_action_type = INTEROP_RUNTIME_UNDEFINED;
        value_action_type = runtimeType(value_action);
        valueSerializer.writeInt8(value_action_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_action_type)) {
            const auto value_action_value = value_action.value;
            valueSerializer.writeString(value_action_value);
        }
        const auto value_parameters = value.parameters;
        OH_Int32 value_parameters_type = INTEROP_RUNTIME_UNDEFINED;
        value_parameters_type = runtimeType(value_parameters);
        valueSerializer.writeInt8(value_parameters_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_parameters_type)) {
            const auto value_parameters_value = value_parameters.value;
            valueSerializer.writeInt32(value_parameters_value.size);
            for (int32_t i = 0; i < value_parameters_value.size; i++) {
                auto value_parameters_value_key = value_parameters_value.keys[i];
                auto value_parameters_value_value = value_parameters_value.values[i];
                valueSerializer.writeString(value_parameters_value_key);
                valueSerializer.writeCustomObject("Object", value_parameters_value_value);
            }
        }
        const auto value_entities = value.entities;
        OH_Int32 value_entities_type = INTEROP_RUNTIME_UNDEFINED;
        value_entities_type = runtimeType(value_entities);
        valueSerializer.writeInt8(value_entities_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_entities_type)) {
            const auto value_entities_value = value_entities.value;
            valueSerializer.writeInt32(value_entities_value.length);
            for (int i = 0; i < value_entities_value.length; i++) {
                const OH_String value_entities_value_element = value_entities_value.array[i];
                valueSerializer.writeString(value_entities_value_element);
            }
        }
        const auto value_moduleName = value.moduleName;
        OH_Int32 value_moduleName_type = INTEROP_RUNTIME_UNDEFINED;
        value_moduleName_type = runtimeType(value_moduleName);
        valueSerializer.writeInt8(value_moduleName_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_moduleName_type)) {
            const auto value_moduleName_value = value_moduleName.value;
            valueSerializer.writeString(value_moduleName_value);
        }
        const auto value_fds = value.fds;
        OH_Int32 value_fds_type = INTEROP_RUNTIME_UNDEFINED;
        value_fds_type = runtimeType(value_fds);
        valueSerializer.writeInt8(value_fds_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_fds_type)) {
            const auto value_fds_value = value_fds.value;
            valueSerializer.writeInt32(value_fds_value.size);
            for (int32_t i = 0; i < value_fds_value.size; i++) {
                auto value_fds_value_key = value_fds_value.keys[i];
                auto value_fds_value_value = value_fds_value.values[i];
                valueSerializer.writeString(value_fds_value_key);
                valueSerializer.writeNumber(value_fds_value_value);
            }
        }
    }
    void writeUIAbilityContext(OH_UIAbilityContext_UIAbilityContext value)
    {
        Serializer& valueSerializer = *this;
        valueSerializer.writePointer(value);
    }
};

class Deserializer : public DeserializerBase {
    public:
    Deserializer(uint8_t* data, OH_Int32 length) : DeserializerBase(data, length) {
    }
    OH_UIAbilityContext_Want readWant()
    {
        OH_UIAbilityContext_Want value = {};
        Deserializer& valueDeserializer = *this;
        const auto bundleName_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String bundleName_buf = {};
        bundleName_buf.tag = bundleName_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (bundleName_buf_runtimeType))
        {
            bundleName_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.bundleName = bundleName_buf;
        const auto abilityName_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String abilityName_buf = {};
        abilityName_buf.tag = abilityName_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (abilityName_buf_runtimeType))
        {
            abilityName_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.abilityName = abilityName_buf;
        const auto deviceId_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String deviceId_buf = {};
        deviceId_buf.tag = deviceId_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (deviceId_buf_runtimeType))
        {
            deviceId_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.deviceId = deviceId_buf;
        const auto uri_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String uri_buf = {};
        uri_buf.tag = uri_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (uri_buf_runtimeType))
        {
            uri_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.uri = uri_buf;
        const auto type_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String type_buf = {};
        type_buf.tag = type_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (type_buf_runtimeType))
        {
            type_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.type = type_buf;
        const auto flags_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number flags_buf = {};
        flags_buf.tag = flags_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (flags_buf_runtimeType))
        {
            flags_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.flags = flags_buf;
        const auto action_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String action_buf = {};
        action_buf.tag = action_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (action_buf_runtimeType))
        {
            action_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.action = action_buf;
        const auto parameters_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_Map_String_CustomObject parameters_buf = {};
        parameters_buf.tag = parameters_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (parameters_buf_runtimeType))
        {
            const OH_Int32 parameters_buf__size = valueDeserializer.readInt32();
            Map_String_CustomObject parameters_buf_ = {};
            valueDeserializer.resizeMap<Map_String_CustomObject, OH_String, OH_CustomObject>(&parameters_buf_, parameters_buf__size);
            for (int parameters_buf__i = 0; parameters_buf__i < parameters_buf__size; parameters_buf__i++) {
                const OH_String parameters_buf__key = static_cast<OH_String>(valueDeserializer.readString());
                const OH_CustomObject parameters_buf__value = static_cast<OH_CustomObject>(valueDeserializer.readCustomObject("Object"));
                parameters_buf_.keys[parameters_buf__i] = parameters_buf__key;
                parameters_buf_.values[parameters_buf__i] = parameters_buf__value;
            }
            parameters_buf.value = parameters_buf_;
        }
        value.parameters = parameters_buf;
        const auto entities_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_Array_String entities_buf = {};
        entities_buf.tag = entities_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (entities_buf_runtimeType))
        {
            const OH_Int32 entities_buf__length = valueDeserializer.readInt32();
            Array_String entities_buf_ = {};
            valueDeserializer.resizeArray<std::decay<decltype(entities_buf_)>::type,
        std::decay<decltype(*entities_buf_.array)>::type>(&entities_buf_, entities_buf__length);
            for (int entities_buf__i = 0; entities_buf__i < entities_buf__length; entities_buf__i++) {
                entities_buf_.array[entities_buf__i] = static_cast<OH_String>(valueDeserializer.readString());
            }
            entities_buf.value = entities_buf_;
        }
        value.entities = entities_buf;
        const auto moduleName_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_String moduleName_buf = {};
        moduleName_buf.tag = moduleName_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (moduleName_buf_runtimeType))
        {
            moduleName_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.moduleName = moduleName_buf;
        const auto fds_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(valueDeserializer.readInt8());
        Opt_Map_String_Number fds_buf = {};
        fds_buf.tag = fds_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (fds_buf_runtimeType))
        {
            const OH_Int32 fds_buf__size = valueDeserializer.readInt32();
            Map_String_Number fds_buf_ = {};
            valueDeserializer.resizeMap<Map_String_Number, OH_String, OH_Number>(&fds_buf_, fds_buf__size);
            for (int fds_buf__i = 0; fds_buf__i < fds_buf__size; fds_buf__i++) {
                const OH_String fds_buf__key = static_cast<OH_String>(valueDeserializer.readString());
                const OH_Number fds_buf__value = static_cast<OH_Number>(valueDeserializer.readNumber());
                fds_buf_.keys[fds_buf__i] = fds_buf__key;
                fds_buf_.values[fds_buf__i] = fds_buf__value;
            }
            fds_buf.value = fds_buf_;
        }
        value.fds = fds_buf;
        return value;
    }
    OH_UIAbilityContext_UIAbilityContext readUIAbilityContext()
    {
        Deserializer& valueDeserializer = *this;
        OH_NativePointer ptr = valueDeserializer.readPointer();
        return static_cast<OH_UIAbilityContext_UIAbilityContext>(ptr);
    }
};
OH_UIAbilityContext_UIAbilityContextHandle UIAbilityContext_constructImpl();
void UIAbilityContext_destructImpl(OH_UIAbilityContext_UIAbilityContextHandle thiz);
void UIAbilityContext_startAbilityImpl(OH_NativePointer thisPtr, const OH_UIAbilityContext_Want* want, const UIAbilityContext_AsyncCallback_Void* callback_);
void UIAbilityContext_terminateSelf0Impl(OH_NativePointer thisPtr, const UIAbilityContext_AsyncCallback_Void* callback_);
void UIAbilityContext_terminateSelf1Impl(OH_NativePointer thisPtr, const UIAbilityContext_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
const OH_UIAbilityContext_UIAbilityContextModifier* OH_UIAbilityContext_UIAbilityContextModifierImpl() {
    const static OH_UIAbilityContext_UIAbilityContextModifier instance = {
        &UIAbilityContext_constructImpl,
        &UIAbilityContext_destructImpl,
        &UIAbilityContext_startAbilityImpl,
        &UIAbilityContext_terminateSelf0Impl,
        &UIAbilityContext_terminateSelf1Impl,
    };
    return &instance;
}
const OH_UIAbilityContext_API* GetUIAbilityContextAPIImpl(int version) {
    const static OH_UIAbilityContext_API api = {
        1, // version
        &OH_UIAbilityContext_UIAbilityContextModifierImpl,
    };
    if (version != api.version) return nullptr;
    return &api;
}

// Accessors

OH_NativePointer impl_UIAbilityContext_ctor() {
        return 
        GetUIAbilityContextAPIImpl(UIAbilityContext_API_VERSION)->UIAbilityContext()->construct();
}
KOALA_INTEROP_0(UIAbilityContext_ctor, OH_NativePointer)
OH_NativePointer impl_UIAbilityContext_getFinalizer() {
        return (OH_NativePointer) GetUIAbilityContextAPIImpl(UIAbilityContext_API_VERSION)->UIAbilityContext()->destruct;
}
KOALA_INTEROP_0(UIAbilityContext_getFinalizer, OH_NativePointer)
void impl_UIAbilityContext_startAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_UIAbilityContext_Want want_value = thisDeserializer.readWant();;
        UIAbilityContext_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_UIAbilityContext_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;

        GetUIAbilityContextAPIImpl(UIAbilityContext_API_VERSION)->UIAbilityContext()->startAbility(thisPtr, (const OH_UIAbilityContext_Want*)&want_value, (const UIAbilityContext_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbility, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_terminateSelf0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        UIAbilityContext_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_UIAbilityContext_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;

        GetUIAbilityContextAPIImpl(UIAbilityContext_API_VERSION)->UIAbilityContext()->terminateSelf0(thisPtr, (const UIAbilityContext_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_terminateSelf0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_terminateSelf1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        UIAbilityContext_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_UIAbilityContext_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;

        GetUIAbilityContextAPIImpl(UIAbilityContext_API_VERSION)->UIAbilityContext()->terminateSelf1(thisPtr, (const UIAbilityContext_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_terminateSelf1, OH_NativePointer, uint8_t*, int32_t)
void deserializeAndCallAsyncCallback_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    _call(_resourceId);
}
void deserializeAndCallSyncAsyncCallback_Void(OH_UIAbilityContext_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_UIAbilityContext_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    _callSync(vmContext, _resourceId);
}
void deserializeAndCallCallback_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto error_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(thisDeserializer.readInt8());
    Opt_Array_String error_buf = {};
    error_buf.tag = error_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (error_buf_runtimeType))
    {
        const OH_Int32 error_buf__length = thisDeserializer.readInt32();
        Array_String error_buf_ = {};
        thisDeserializer.resizeArray<std::decay<decltype(error_buf_)>::type,
        std::decay<decltype(*error_buf_.array)>::type>(&error_buf_, error_buf__length);
        for (int error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_.array[error_buf__i] = static_cast<OH_String>(thisDeserializer.readString());
        }
        error_buf.value = error_buf_;
    }
    Opt_Array_String error = error_buf;
    _call(_resourceId, error);
}
void deserializeAndCallSyncCallback_Opt_Array_String_Void(OH_UIAbilityContext_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_UIAbilityContext_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto error_buf_runtimeType = static_cast<OH_UIAbilityContext_RuntimeType>(thisDeserializer.readInt8());
    Opt_Array_String error_buf = {};
    error_buf.tag = error_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (error_buf_runtimeType))
    {
        const OH_Int32 error_buf__length = thisDeserializer.readInt32();
        Array_String error_buf_ = {};
        thisDeserializer.resizeArray<std::decay<decltype(error_buf_)>::type,
        std::decay<decltype(*error_buf_.array)>::type>(&error_buf_, error_buf__length);
        for (int error_buf__i = 0; error_buf__i < error_buf__length; error_buf__i++) {
            error_buf_.array[error_buf__i] = static_cast<OH_String>(thisDeserializer.readString());
        }
        error_buf.value = error_buf_;
    }
    Opt_Array_String error = error_buf;
    _callSync(vmContext, _resourceId, error);
}
void deserializeAndCallCallback_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    _call(_resourceId);
}
void deserializeAndCallSyncCallback_Void(OH_UIAbilityContext_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_UIAbilityContext_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    _callSync(vmContext, _resourceId);
}
void deserializeAndCallCallback(OH_Int32 kind, uint8_t* thisArray, OH_Int32 thisLength)
{
    switch (kind) {
        case 1075219926/*Kind_AsyncCallback_Void*/: return deserializeAndCallAsyncCallback_Void(thisArray, thisLength);
        case -543655128/*Kind_Callback_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Array_String_Void(thisArray, thisLength);
        case -1867723152/*Kind_Callback_Void*/: return deserializeAndCallCallback_Void(thisArray, thisLength);
    }
    printf("Unknown callback kind\n");
}
void deserializeAndCallCallbackSync(OH_UIAbilityContext_VMContext vmContext, OH_Int32 kind, uint8_t* thisArray, OH_Int32 thisLength)
{
    switch (kind) {
        case 1075219926/*Kind_AsyncCallback_Void*/: return deserializeAndCallSyncAsyncCallback_Void(vmContext, thisArray, thisLength);
        case -543655128/*Kind_Callback_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case -1867723152/*Kind_Callback_Void*/: return deserializeAndCallSyncCallback_Void(vmContext, thisArray, thisLength);
    }
    printf("Unknown callback kind\n");
}
void callManagedAsyncCallback_Void(OH_Int32 resourceId)
{
    CallbackBuffer _buffer = {{}, {}};
    const OH_UIAbilityContext_CallbackResource _callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    _buffer.resourceHolder.holdCallbackResource(&_callbackResource);
    Serializer argsSerializer = Serializer(_buffer.buffer, sizeof(_buffer.buffer), &(_buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_AsyncCallback_Void);
    argsSerializer.writeInt32(resourceId);
    enqueueCallback(&_buffer);
}
void callManagedAsyncCallback_VoidSync(OH_UIAbilityContext_VMContext vmContext, OH_Int32 resourceId)
{
    uint8_t _buffer[60 * 4];
    Serializer argsSerializer = Serializer(_buffer, sizeof(_buffer), nullptr);
    argsSerializer.writeInt32(Kind_AsyncCallback_Void);
    argsSerializer.writeInt32(resourceId);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(_buffer), _buffer);
}
void callManagedCallback_Opt_Array_String_Void(OH_Int32 resourceId, Opt_Array_String error)
{
    CallbackBuffer _buffer = {{}, {}};
    const OH_UIAbilityContext_CallbackResource _callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    _buffer.resourceHolder.holdCallbackResource(&_callbackResource);
    Serializer argsSerializer = Serializer(_buffer.buffer, sizeof(_buffer.buffer), &(_buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 error_type = INTEROP_RUNTIME_UNDEFINED;
    error_type = runtimeType(error);
    argsSerializer.writeInt8(error_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (error_type)) {
        const auto error_value = error.value;
        argsSerializer.writeInt32(error_value.length);
        for (int i = 0; i < error_value.length; i++) {
            const OH_String error_value_element = error_value.array[i];
            argsSerializer.writeString(error_value_element);
        }
    }
    enqueueCallback(&_buffer);
}
void callManagedCallback_Opt_Array_String_VoidSync(OH_UIAbilityContext_VMContext vmContext, OH_Int32 resourceId, Opt_Array_String error)
{
    uint8_t _buffer[60 * 4];
    Serializer argsSerializer = Serializer(_buffer, sizeof(_buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 error_type = INTEROP_RUNTIME_UNDEFINED;
    error_type = runtimeType(error);
    argsSerializer.writeInt8(error_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (error_type)) {
        const auto error_value = error.value;
        argsSerializer.writeInt32(error_value.length);
        for (int i = 0; i < error_value.length; i++) {
            const OH_String error_value_element = error_value.array[i];
            argsSerializer.writeString(error_value_element);
        }
    }
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(_buffer), _buffer);
}
void callManagedCallback_Void(OH_Int32 resourceId)
{
    CallbackBuffer _buffer = {{}, {}};
    const OH_UIAbilityContext_CallbackResource _callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    _buffer.resourceHolder.holdCallbackResource(&_callbackResource);
    Serializer argsSerializer = Serializer(_buffer.buffer, sizeof(_buffer.buffer), &(_buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Void);
    argsSerializer.writeInt32(resourceId);
    enqueueCallback(&_buffer);
}
void callManagedCallback_VoidSync(OH_UIAbilityContext_VMContext vmContext, OH_Int32 resourceId)
{
    uint8_t _buffer[60 * 4];
    Serializer argsSerializer = Serializer(_buffer, sizeof(_buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Void);
    argsSerializer.writeInt32(resourceId);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(_buffer), _buffer);
}
OH_NativePointer getManagedCallbackCaller(CallbackKind kind)
{
    switch (kind) {
        case Kind_AsyncCallback_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_Void);
        case Kind_Callback_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_Array_String_Void);
        case Kind_Callback_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Void);
    }
    return nullptr;
}
OH_NativePointer getManagedCallbackCallerSync(CallbackKind kind)
{
    switch (kind) {
        case Kind_AsyncCallback_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_VoidSync);
        case Kind_Callback_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_Array_String_VoidSync);
        case Kind_Callback_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_VoidSync);
    }
    return nullptr;
}
const OH_AnyAPI* impls[16] = { 0 };


const OH_AnyAPI* GetAnyAPIImpl(int kind, int version) {
    switch (kind) {
        case OH_UIAbilityContext_API_KIND:
            return reinterpret_cast<const OH_AnyAPI*>(GetUIAbilityContextAPIImpl(version));
        default:
            return nullptr;
    }
}

extern "C" const OH_AnyAPI* GetAnyAPI(int kind, int version) {
    if (kind < 0 || kind > 15) return nullptr;
    if (!impls[kind]) {
        impls[kind] = GetAnyAPIImpl(kind, version);
    }
    return impls[kind];
}
