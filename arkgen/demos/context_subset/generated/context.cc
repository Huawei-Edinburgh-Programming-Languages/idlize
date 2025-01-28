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

#include "context.h"

#define KOALA_INTEROP_MODULE CONTEXTNativeModule
#include "common-interop.h"
#include "callback-resource.h"
#include "SerializerBase.h"
#include "DeserializerBase.h"
#include <deque>
#include <unordered_map>

CustomDeserializer * DeserializerBase::customDeserializers = nullptr;

typedef enum CallbackKind {
    Kind_AsyncCallback_AbilityResult_Void = 1801791970,
    Kind_AsyncCallback_dialogRequest_RequestResult_Void = -1652909257,
    Kind_AsyncCallback_String_Void = 789188988,
    Kind_AsyncCallback_Void = 1075219926,
    Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void = 2092467560,
    Kind_Callback_Opt_Array_String_Void = -543655128,
    Kind_Callback_Opt_Caller_Opt_Array_String_Void = -701632170,
    Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void = 1663507741,
    Kind_Callback_Opt_String_Opt_Array_String_Void = 1813490422,
    Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void = -1175461650,
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
inline OH_CONTEXT_RuntimeType runtimeType(const OH_Int32& value)
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Int32& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const Array_String& value)
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Array_String& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_Literal_Empty& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_Literal_Empty* value) {
    result->append("{");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_Literal_Empty* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Literal_Empty& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_String& value)
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_String& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_Number& value)
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Number& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const Array_CustomObject& value)
{
    return INTEROP_RUNTIME_OBJECT;
}

template <>
inline void WriteToString(std::string* result, const OH_CustomObject* value);

inline void WriteToString(std::string* result, const Array_CustomObject* value) {
    int32_t count = value->length;
    result->append("{.array=allocArray<OH_CustomObject, " + std::to_string(count) + ">({{");
    for (int i = 0; i < count; i++) {
        if (i > 0) result->append(", ");
        WriteToString(result, (const OH_CustomObject*)&value->array[i]);
    }
    result->append("}})");
    result->append(", .length=");
    result->append(std::to_string(value->length));
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_Array_CustomObject* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Array_CustomObject& value)
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CustomObject& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_contextConstant_StartupVisibility& value)
{
    return INTEROP_RUNTIME_NUMBER;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_contextConstant_StartupVisibility value) {
    result->append("OH_CONTEXT_contextConstant_StartupVisibility(");
    WriteToString(result, (OH_Int32) value);
    result->append(")");
}
template <>
inline void WriteToString(std::string* result, const Opt_contextConstant_StartupVisibility* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_contextConstant_StartupVisibility& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_contextConstant_ProcessMode& value)
{
    return INTEROP_RUNTIME_NUMBER;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_contextConstant_ProcessMode value) {
    result->append("OH_CONTEXT_contextConstant_ProcessMode(");
    WriteToString(result, (OH_Int32) value);
    result->append(")");
}
template <>
inline void WriteToString(std::string* result, const Opt_contextConstant_ProcessMode* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_contextConstant_ProcessMode& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_Boolean& value)
{
    return INTEROP_RUNTIME_BOOLEAN;
}
template <>
inline void WriteToString(std::string* result, const Opt_Boolean* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Boolean& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_Want& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_Want* value) {
    result->append("{");
    // OH_String deviceId
    result->append(".deviceId=");
    WriteToString(result, &value->deviceId);
    // OH_String bundleName
    result->append(", ");
    result->append(".bundleName=");
    WriteToString(result, &value->bundleName);
    // OH_String abilityName
    result->append(", ");
    result->append(".abilityName=");
    WriteToString(result, &value->abilityName);
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
    // OH_CONTEXT_Literal_Empty parameters
    result->append(", ");
    result->append(".parameters=");
    WriteToString(result, &value->parameters);
    // Array_String entities
    result->append(", ");
    result->append(".entities=");
    WriteToString(result, &value->entities);
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Want& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_AsyncCallback_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_AsyncCallback_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_AsyncCallback_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_AsyncCallback_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_StartOptions& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_StartOptions* value) {
    result->append("{");
    // OH_Number windowMode
    result->append(".windowMode=");
    WriteToString(result, &value->windowMode);
    // OH_Number displayId
    result->append(", ");
    result->append(".displayId=");
    WriteToString(result, &value->displayId);
    // OH_Boolean withAnimation
    result->append(", ");
    result->append(".withAnimation=");
    WriteToString(result, &value->withAnimation);
    // OH_Number windowLeft
    result->append(", ");
    result->append(".windowLeft=");
    WriteToString(result, &value->windowLeft);
    // OH_Number windowTop
    result->append(", ");
    result->append(".windowTop=");
    WriteToString(result, &value->windowTop);
    // OH_Number windowWidth
    result->append(", ");
    result->append(".windowWidth=");
    WriteToString(result, &value->windowWidth);
    // OH_Number windowHeight
    result->append(", ");
    result->append(".windowHeight=");
    WriteToString(result, &value->windowHeight);
    // OH_Boolean windowFocused
    result->append(", ");
    result->append(".windowFocused=");
    WriteToString(result, &value->windowFocused);
    // OH_CONTEXT_contextConstant_ProcessMode processMode
    result->append(", ");
    result->append(".processMode=");
    WriteToString(result, &value->processMode);
    // OH_CONTEXT_contextConstant_StartupVisibility startupVisibility
    result->append(", ");
    result->append(".startupVisibility=");
    WriteToString(result, &value->startupVisibility);
    // OH_CONTEXT_CustomObject startWindowIcon
    result->append(", ");
    result->append(".startWindowIcon=");
    WriteToString(result, &value->startWindowIcon);
    // OH_String startWindowBackgroundColor
    result->append(", ");
    result->append(".startWindowBackgroundColor=");
    WriteToString(result, &value->startWindowBackgroundColor);
    // Array_CustomObject supportWindowModes
    result->append(", ");
    result->append(".supportWindowModes=");
    WriteToString(result, &value->supportWindowModes);
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_StartOptions* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_StartOptions& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_AsyncCallback_AbilityResult_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_AsyncCallback_AbilityResult_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_AsyncCallback_AbilityResult_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_AsyncCallback_AbilityResult_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_contextConstant_AreaMode& value)
{
    return INTEROP_RUNTIME_NUMBER;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_contextConstant_AreaMode value) {
    result->append("OH_CONTEXT_contextConstant_AreaMode(");
    WriteToString(result, (OH_Int32) value);
    result->append(")");
}
template <>
inline void WriteToString(std::string* result, const Opt_contextConstant_AreaMode* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_contextConstant_AreaMode& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_AsyncCallback_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_AsyncCallback_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_AsyncCallback_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_AsyncCallback_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Opt_String_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Opt_String_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Opt_String_Opt_Array_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Opt_String_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Opt_Array_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* value) {
    result->append("{");
    result->append(".resource=");
    WriteToString(result, &value->resource);
    result->append(", .call=0");
    result->append("}");
}
template <>
inline void WriteToString(std::string* result, const Opt_CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* value) {
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const OH_CONTEXT_CustomObject& value)
{
    return INTEROP_RUNTIME_OBJECT;
}
template <>
inline void WriteToString(std::string* result, const OH_CONTEXT_CustomObject* value) {
}
template <>
inline OH_CONTEXT_RuntimeType runtimeType(const Map_String_CustomObject& value)
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
inline OH_CONTEXT_RuntimeType runtimeType(const Opt_Map_String_CustomObject& value)
{
    return (value.tag != INTEROP_TAG_UNDEFINED) ? (INTEROP_RUNTIME_OBJECT) : (INTEROP_RUNTIME_UNDEFINED);
}
class Serializer : public SerializerBase {
    public:
    Serializer(uint8_t* data, OH_UInt32 dataLength = 0, CallbackResourceHolder* resourceHolder = nullptr) : SerializerBase(data, dataLength, resourceHolder) {
    }
    void writeWant(OH_CONTEXT_Want value)
    {
        Serializer& valueSerializer = *this;
        const auto value_deviceId = value.deviceId;
        OH_Int32 value_deviceId_type = INTEROP_RUNTIME_UNDEFINED;
        value_deviceId_type = runtimeType(value_deviceId);
        valueSerializer.writeInt8(value_deviceId_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_deviceId_type)) {
            const auto value_deviceId_value = value_deviceId.value;
            valueSerializer.writeString(value_deviceId_value);
        }
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
    }
    void writeStartOptions(OH_CONTEXT_StartOptions value)
    {
        Serializer& valueSerializer = *this;
        const auto value_windowMode = value.windowMode;
        OH_Int32 value_windowMode_type = INTEROP_RUNTIME_UNDEFINED;
        value_windowMode_type = runtimeType(value_windowMode);
        valueSerializer.writeInt8(value_windowMode_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_windowMode_type)) {
            const auto value_windowMode_value = value_windowMode.value;
            valueSerializer.writeNumber(value_windowMode_value);
        }
        const auto value_displayId = value.displayId;
        OH_Int32 value_displayId_type = INTEROP_RUNTIME_UNDEFINED;
        value_displayId_type = runtimeType(value_displayId);
        valueSerializer.writeInt8(value_displayId_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_displayId_type)) {
            const auto value_displayId_value = value_displayId.value;
            valueSerializer.writeNumber(value_displayId_value);
        }
        const auto value_withAnimation = value.withAnimation;
        OH_Int32 value_withAnimation_type = INTEROP_RUNTIME_UNDEFINED;
        value_withAnimation_type = runtimeType(value_withAnimation);
        valueSerializer.writeInt8(value_withAnimation_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_withAnimation_type)) {
            const auto value_withAnimation_value = value_withAnimation.value;
            valueSerializer.writeBoolean(value_withAnimation_value);
        }
        const auto value_windowLeft = value.windowLeft;
        OH_Int32 value_windowLeft_type = INTEROP_RUNTIME_UNDEFINED;
        value_windowLeft_type = runtimeType(value_windowLeft);
        valueSerializer.writeInt8(value_windowLeft_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_windowLeft_type)) {
            const auto value_windowLeft_value = value_windowLeft.value;
            valueSerializer.writeNumber(value_windowLeft_value);
        }
        const auto value_windowTop = value.windowTop;
        OH_Int32 value_windowTop_type = INTEROP_RUNTIME_UNDEFINED;
        value_windowTop_type = runtimeType(value_windowTop);
        valueSerializer.writeInt8(value_windowTop_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_windowTop_type)) {
            const auto value_windowTop_value = value_windowTop.value;
            valueSerializer.writeNumber(value_windowTop_value);
        }
        const auto value_windowWidth = value.windowWidth;
        OH_Int32 value_windowWidth_type = INTEROP_RUNTIME_UNDEFINED;
        value_windowWidth_type = runtimeType(value_windowWidth);
        valueSerializer.writeInt8(value_windowWidth_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_windowWidth_type)) {
            const auto value_windowWidth_value = value_windowWidth.value;
            valueSerializer.writeNumber(value_windowWidth_value);
        }
        const auto value_windowHeight = value.windowHeight;
        OH_Int32 value_windowHeight_type = INTEROP_RUNTIME_UNDEFINED;
        value_windowHeight_type = runtimeType(value_windowHeight);
        valueSerializer.writeInt8(value_windowHeight_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_windowHeight_type)) {
            const auto value_windowHeight_value = value_windowHeight.value;
            valueSerializer.writeNumber(value_windowHeight_value);
        }
        const auto value_windowFocused = value.windowFocused;
        OH_Int32 value_windowFocused_type = INTEROP_RUNTIME_UNDEFINED;
        value_windowFocused_type = runtimeType(value_windowFocused);
        valueSerializer.writeInt8(value_windowFocused_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_windowFocused_type)) {
            const auto value_windowFocused_value = value_windowFocused.value;
            valueSerializer.writeBoolean(value_windowFocused_value);
        }
        const auto value_processMode = value.processMode;
        OH_Int32 value_processMode_type = INTEROP_RUNTIME_UNDEFINED;
        value_processMode_type = runtimeType(value_processMode);
        valueSerializer.writeInt8(value_processMode_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_processMode_type)) {
            const auto value_processMode_value = value_processMode.value;
            valueSerializer.writeInt32(static_cast<OH_CONTEXT_contextConstant_ProcessMode>(value_processMode_value));
        }
        const auto value_startupVisibility = value.startupVisibility;
        OH_Int32 value_startupVisibility_type = INTEROP_RUNTIME_UNDEFINED;
        value_startupVisibility_type = runtimeType(value_startupVisibility);
        valueSerializer.writeInt8(value_startupVisibility_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_startupVisibility_type)) {
            const auto value_startupVisibility_value = value_startupVisibility.value;
            valueSerializer.writeInt32(static_cast<OH_CONTEXT_contextConstant_StartupVisibility>(value_startupVisibility_value));
        }
        const auto value_startWindowIcon = value.startWindowIcon;
        OH_Int32 value_startWindowIcon_type = INTEROP_RUNTIME_UNDEFINED;
        value_startWindowIcon_type = runtimeType(value_startWindowIcon);
        valueSerializer.writeInt8(value_startWindowIcon_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_startWindowIcon_type)) {
            const auto value_startWindowIcon_value = value_startWindowIcon.value;
            valueSerializer.writeCustomObject("image.PixelMap", value_startWindowIcon_value);
        }
        const auto value_startWindowBackgroundColor = value.startWindowBackgroundColor;
        OH_Int32 value_startWindowBackgroundColor_type = INTEROP_RUNTIME_UNDEFINED;
        value_startWindowBackgroundColor_type = runtimeType(value_startWindowBackgroundColor);
        valueSerializer.writeInt8(value_startWindowBackgroundColor_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_startWindowBackgroundColor_type)) {
            const auto value_startWindowBackgroundColor_value = value_startWindowBackgroundColor.value;
            valueSerializer.writeString(value_startWindowBackgroundColor_value);
        }
        const auto value_supportWindowModes = value.supportWindowModes;
        OH_Int32 value_supportWindowModes_type = INTEROP_RUNTIME_UNDEFINED;
        value_supportWindowModes_type = runtimeType(value_supportWindowModes);
        valueSerializer.writeInt8(value_supportWindowModes_type);
        if ((INTEROP_RUNTIME_UNDEFINED) != (value_supportWindowModes_type)) {
            const auto value_supportWindowModes_value = value_supportWindowModes.value;
            valueSerializer.writeInt32(value_supportWindowModes_value.length);
            for (int i = 0; i < value_supportWindowModes_value.length; i++) {
                const OH_CONTEXT_CustomObject value_supportWindowModes_value_element = value_supportWindowModes_value.array[i];
                valueSerializer.writeCustomObject("bundleManager.SupportWindowMode", value_supportWindowModes_value_element);
            }
        }
    }
};

class Deserializer : public DeserializerBase {
    public:
    Deserializer(uint8_t* data, OH_Int32 length) : DeserializerBase(data, length) {
    }
    OH_CONTEXT_Want readWant()
    {
        OH_CONTEXT_Want value = {};
        Deserializer& valueDeserializer = *this;
        const auto deviceId_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String deviceId_buf = {};
        deviceId_buf.tag = deviceId_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (deviceId_buf_runtimeType))
        {
            deviceId_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.deviceId = deviceId_buf;
        const auto bundleName_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String bundleName_buf = {};
        bundleName_buf.tag = bundleName_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (bundleName_buf_runtimeType))
        {
            bundleName_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.bundleName = bundleName_buf;
        const auto abilityName_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String abilityName_buf = {};
        abilityName_buf.tag = abilityName_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (abilityName_buf_runtimeType))
        {
            abilityName_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.abilityName = abilityName_buf;
        const auto uri_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String uri_buf = {};
        uri_buf.tag = uri_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (uri_buf_runtimeType))
        {
            uri_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.uri = uri_buf;
        const auto type_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String type_buf = {};
        type_buf.tag = type_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (type_buf_runtimeType))
        {
            type_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.type = type_buf;
        const auto flags_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number flags_buf = {};
        flags_buf.tag = flags_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (flags_buf_runtimeType))
        {
            flags_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.flags = flags_buf;
        const auto action_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String action_buf = {};
        action_buf.tag = action_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (action_buf_runtimeType))
        {
            action_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.action = action_buf;
        const auto parameters_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Literal_Empty parameters_buf = {};
        parameters_buf.tag = parameters_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (parameters_buf_runtimeType))
        {
            OH_CONTEXT_Literal_Empty parameters_buf_ = {};
            parameters_buf.value = parameters_buf_;
        }
        value.parameters = parameters_buf;
        const auto entities_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
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
        return value;
    }
    OH_CONTEXT_StartOptions readStartOptions()
    {
        OH_CONTEXT_StartOptions value = {};
        Deserializer& valueDeserializer = *this;
        const auto windowMode_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number windowMode_buf = {};
        windowMode_buf.tag = windowMode_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (windowMode_buf_runtimeType))
        {
            windowMode_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.windowMode = windowMode_buf;
        const auto displayId_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number displayId_buf = {};
        displayId_buf.tag = displayId_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (displayId_buf_runtimeType))
        {
            displayId_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.displayId = displayId_buf;
        const auto withAnimation_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Boolean withAnimation_buf = {};
        withAnimation_buf.tag = withAnimation_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (withAnimation_buf_runtimeType))
        {
            withAnimation_buf.value = valueDeserializer.readBoolean();
        }
        value.withAnimation = withAnimation_buf;
        const auto windowLeft_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number windowLeft_buf = {};
        windowLeft_buf.tag = windowLeft_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (windowLeft_buf_runtimeType))
        {
            windowLeft_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.windowLeft = windowLeft_buf;
        const auto windowTop_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number windowTop_buf = {};
        windowTop_buf.tag = windowTop_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (windowTop_buf_runtimeType))
        {
            windowTop_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.windowTop = windowTop_buf;
        const auto windowWidth_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number windowWidth_buf = {};
        windowWidth_buf.tag = windowWidth_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (windowWidth_buf_runtimeType))
        {
            windowWidth_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.windowWidth = windowWidth_buf;
        const auto windowHeight_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Number windowHeight_buf = {};
        windowHeight_buf.tag = windowHeight_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (windowHeight_buf_runtimeType))
        {
            windowHeight_buf.value = static_cast<OH_Number>(valueDeserializer.readNumber());
        }
        value.windowHeight = windowHeight_buf;
        const auto windowFocused_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Boolean windowFocused_buf = {};
        windowFocused_buf.tag = windowFocused_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (windowFocused_buf_runtimeType))
        {
            windowFocused_buf.value = valueDeserializer.readBoolean();
        }
        value.windowFocused = windowFocused_buf;
        const auto processMode_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_contextConstant_ProcessMode processMode_buf = {};
        processMode_buf.tag = processMode_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (processMode_buf_runtimeType))
        {
            processMode_buf.value = static_cast<OH_CONTEXT_contextConstant_ProcessMode>(valueDeserializer.readInt32());
        }
        value.processMode = processMode_buf;
        const auto startupVisibility_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_contextConstant_StartupVisibility startupVisibility_buf = {};
        startupVisibility_buf.tag = startupVisibility_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (startupVisibility_buf_runtimeType))
        {
            startupVisibility_buf.value = static_cast<OH_CONTEXT_contextConstant_StartupVisibility>(valueDeserializer.readInt32());
        }
        value.startupVisibility = startupVisibility_buf;
        const auto startWindowIcon_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_CustomObject startWindowIcon_buf = {};
        startWindowIcon_buf.tag = startWindowIcon_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (startWindowIcon_buf_runtimeType))
        {
            startWindowIcon_buf.value = static_cast<OH_CustomObject>(valueDeserializer.readCustomObject("image.PixelMap"));
        }
        value.startWindowIcon = startWindowIcon_buf;
        const auto startWindowBackgroundColor_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_String startWindowBackgroundColor_buf = {};
        startWindowBackgroundColor_buf.tag = startWindowBackgroundColor_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (startWindowBackgroundColor_buf_runtimeType))
        {
            startWindowBackgroundColor_buf.value = static_cast<OH_String>(valueDeserializer.readString());
        }
        value.startWindowBackgroundColor = startWindowBackgroundColor_buf;
        const auto supportWindowModes_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(valueDeserializer.readInt8());
        Opt_Array_CustomObject supportWindowModes_buf = {};
        supportWindowModes_buf.tag = supportWindowModes_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (supportWindowModes_buf_runtimeType))
        {
            const OH_Int32 supportWindowModes_buf__length = valueDeserializer.readInt32();
            Array_CustomObject supportWindowModes_buf_ = {};
            valueDeserializer.resizeArray<std::decay<decltype(supportWindowModes_buf_)>::type,
        std::decay<decltype(*supportWindowModes_buf_.array)>::type>(&supportWindowModes_buf_, supportWindowModes_buf__length);
            for (int supportWindowModes_buf__i = 0; supportWindowModes_buf__i < supportWindowModes_buf__length; supportWindowModes_buf__i++) {
                supportWindowModes_buf_.array[supportWindowModes_buf__i] = static_cast<OH_CustomObject>(valueDeserializer.readCustomObject("bundleManager.SupportWindowMode"));
            }
            supportWindowModes_buf.value = supportWindowModes_buf_;
        }
        value.supportWindowModes = supportWindowModes_buf;
        return value;
    }
};
OH_CONTEXT_ContextHandle Context_constructImpl();
void Context_destructImpl(OH_CONTEXT_ContextHandle thiz);
OH_CONTEXT_Context Context_createBundleContextImpl(OH_NativePointer thisPtr, const OH_String* bundleName);
OH_CONTEXT_Context Context_createModuleContext0Impl(OH_NativePointer thisPtr, const OH_String* moduleName);
OH_CONTEXT_Context Context_createModuleContext1Impl(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName);
OH_CONTEXT_resmgr_ResourceManager Context_createSystemHspModuleResourceManagerImpl(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName);
OH_CONTEXT_ApplicationContext Context_getApplicationContextImpl(OH_NativePointer thisPtr);
void Context_getGroupDir0Impl(OH_NativePointer thisPtr, const OH_String* dataGroupID, const CONTEXT_AsyncCallback_String_Void* callback_);
void Context_getGroupDir1Impl(OH_NativePointer thisPtr, const OH_String* dataGroupID, const CONTEXT_Callback_Opt_String_Opt_Array_String_Void* outputArgumentForReturningPromise);
OH_CONTEXT_resmgr_ResourceManager Context_createModuleResourceManagerImpl(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName);
OH_CONTEXT_Context Context_createAreaModeContextImpl(OH_NativePointer thisPtr, const OH_CONTEXT_contextConstant_AreaMode* areaMode);
OH_CONTEXT_Context Context_createDisplayContextImpl(OH_NativePointer thisPtr, const OH_Number* displayId);
OH_CONTEXT_resmgr_ResourceManager ContextgetResourceManagerImpl(OH_CONTEXT_resmgr_ResourceManager thiz);
void ContextsetResourceManagerImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_resmgr_ResourceManager value);
OH_CONTEXT_ApplicationInfo ContextgetApplicationInfoImpl(OH_CONTEXT_ApplicationInfo thiz);
void ContextsetApplicationInfoImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_ApplicationInfo value);
OH_String ContextgetCacheDirImpl(OH_String thiz);
void ContextsetCacheDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetTempDirImpl(OH_String thiz);
void ContextsetTempDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetFilesDirImpl(OH_String thiz);
void ContextsetFilesDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetDatabaseDirImpl(OH_String thiz);
void ContextsetDatabaseDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetPreferencesDirImpl(OH_String thiz);
void ContextsetPreferencesDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetBundleCodeDirImpl(OH_String thiz);
void ContextsetBundleCodeDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetDistributedFilesDirImpl(OH_String thiz);
void ContextsetDistributedFilesDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetResourceDirImpl(OH_String thiz);
void ContextsetResourceDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_String ContextgetCloudFileDirImpl(OH_String thiz);
void ContextsetCloudFileDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_CONTEXT_EventHub ContextgetEventHubImpl(OH_CONTEXT_EventHub thiz);
void ContextsetEventHubImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_EventHub value);
OH_CONTEXT_contextConstant_AreaMode ContextgetAreaImpl(OH_CONTEXT_contextConstant_AreaMode thiz);
void ContextsetAreaImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_contextConstant_AreaMode value);
OH_String ContextgetProcessNameImpl(OH_String thiz);
void ContextsetProcessNameImpl(OH_CONTEXT_ContextHandle thiz, OH_String value);
OH_CONTEXT_UIAbilityContextHandle UIAbilityContext_constructImpl();
void UIAbilityContext_destructImpl(OH_CONTEXT_UIAbilityContextHandle thiz);
void UIAbilityContext_startAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* startAbilityCallback);
void UIAbilityContext_startAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* startAbilityCallback);
void UIAbilityContext_startAbility2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_openLinkImpl(OH_NativePointer thisPtr, const OH_String* link, const Opt_CustomObject* options, const Opt_CONTEXT_AsyncCallback_AbilityResult_Void* callback_, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startAbilityAsCaller0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityAsCaller1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityAsCaller2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startAbilityByCallImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startAbilityByCallWithAccountImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startAbilityWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityWithAccount2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startAbilityForResult0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_);
void UIAbilityContext_startAbilityForResult1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_);
void UIAbilityContext_startAbilityForResult2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startAbilityForResultWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_);
void UIAbilityContext_startAbilityForResultWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityForResultWithAccount2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startServiceExtensionAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startServiceExtensionAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_startServiceExtensionAbilityWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startServiceExtensionAbilityWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_stopServiceExtensionAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_stopServiceExtensionAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_stopServiceExtensionAbilityWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_stopServiceExtensionAbilityWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_terminateSelf0Impl(OH_NativePointer thisPtr, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_terminateSelf1Impl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_terminateSelfWithResult0Impl(OH_NativePointer thisPtr, const OH_CustomObject* parameter, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_terminateSelfWithResult1Impl(OH_NativePointer thisPtr, const OH_CustomObject* parameter, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_backToCallerAbilityWithResultImpl(OH_NativePointer thisPtr, const OH_CustomObject* abilityResult, const OH_String* requestCode, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
OH_Number UIAbilityContext_connectServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CustomObject* options);
OH_Number UIAbilityContext_connectServiceExtensionAbilityWithAccountImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CustomObject* options);
void UIAbilityContext_disconnectServiceExtensionAbility0Impl(OH_NativePointer thisPtr, const OH_Number* connection, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_disconnectServiceExtensionAbility1Impl(OH_NativePointer thisPtr, const OH_Number* connection, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_setMissionLabel0Impl(OH_NativePointer thisPtr, const OH_String* label, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_setMissionLabel1Impl(OH_NativePointer thisPtr, const OH_String* label, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_setMissionIcon0Impl(OH_NativePointer thisPtr, const OH_CustomObject* icon, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_setMissionIcon1Impl(OH_NativePointer thisPtr, const OH_CustomObject* icon, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_setMissionContinueState0Impl(OH_NativePointer thisPtr, const OH_CustomObject* state, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_setMissionContinueState1Impl(OH_NativePointer thisPtr, const OH_CustomObject* state, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_restoreWindowStageImpl(OH_NativePointer thisPtr, const OH_CustomObject* localStorage);
OH_Boolean UIAbilityContext_isTerminatingImpl(OH_NativePointer thisPtr);
void UIAbilityContext_startRecentAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startRecentAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startRecentAbility2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_requestDialogService0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void* result);
void UIAbilityContext_requestDialogService1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_reportDrawnCompletedImpl(OH_NativePointer thisPtr, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityByType0Impl(OH_NativePointer thisPtr, const OH_String* type, const Map_String_CustomObject* wantParam, const OH_CustomObject* abilityStartCallback, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_startAbilityByType1Impl(OH_NativePointer thisPtr, const OH_String* type, const Map_String_CustomObject* wantParam, const OH_CustomObject* abilityStartCallback, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_requestModalUIExtension0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* pickerWant, const CONTEXT_AsyncCallback_Void* callback_);
void UIAbilityContext_requestModalUIExtension1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* pickerWant, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_openAtomicServiceImpl(OH_NativePointer thisPtr, const OH_String* appId, const Opt_CustomObject* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_moveAbilityToBackgroundImpl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_showAbilityImpl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_hideAbilityImpl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_setRestoreEnabledImpl(OH_NativePointer thisPtr, const OH_Boolean* enabled);
void UIAbilityContext_startUIServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_connectUIServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CustomObject* callback_, const CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void* outputArgumentForReturningPromise);
void UIAbilityContext_disconnectUIServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CustomObject* proxy, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
OH_CONTEXT_AbilityInfo UIAbilityContextgetAbilityInfoImpl(OH_CONTEXT_AbilityInfo thiz);
void UIAbilityContextsetAbilityInfoImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_AbilityInfo value);
OH_CONTEXT_HapModuleInfo UIAbilityContextgetCurrentHapModuleInfoImpl(OH_CONTEXT_HapModuleInfo thiz);
void UIAbilityContextsetCurrentHapModuleInfoImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_HapModuleInfo value);
OH_CONTEXT_Configuration UIAbilityContextgetConfigImpl(OH_CONTEXT_Configuration thiz);
void UIAbilityContextsetConfigImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_Configuration value);
OH_CONTEXT_window_WindowStage UIAbilityContextgetWindowStageImpl(OH_CONTEXT_window_WindowStage thiz);
void UIAbilityContextsetWindowStageImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_window_WindowStage value);
const OH_CONTEXT_ContextModifier* OH_CONTEXT_ContextModifierImpl() {
    const static OH_CONTEXT_ContextModifier instance = {
        &Context_constructImpl,
        &Context_destructImpl,
        &Context_createBundleContextImpl,
        &Context_createModuleContext0Impl,
        &Context_createModuleContext1Impl,
        &Context_createSystemHspModuleResourceManagerImpl,
        &Context_getApplicationContextImpl,
        &Context_getGroupDir0Impl,
        &Context_getGroupDir1Impl,
        &Context_createModuleResourceManagerImpl,
        &Context_createAreaModeContextImpl,
        &Context_createDisplayContextImpl,
        &ContextgetResourceManagerImpl,
        &ContextsetResourceManagerImpl,
        &ContextgetApplicationInfoImpl,
        &ContextsetApplicationInfoImpl,
        &ContextgetCacheDirImpl,
        &ContextsetCacheDirImpl,
        &ContextgetTempDirImpl,
        &ContextsetTempDirImpl,
        &ContextgetFilesDirImpl,
        &ContextsetFilesDirImpl,
        &ContextgetDatabaseDirImpl,
        &ContextsetDatabaseDirImpl,
        &ContextgetPreferencesDirImpl,
        &ContextsetPreferencesDirImpl,
        &ContextgetBundleCodeDirImpl,
        &ContextsetBundleCodeDirImpl,
        &ContextgetDistributedFilesDirImpl,
        &ContextsetDistributedFilesDirImpl,
        &ContextgetResourceDirImpl,
        &ContextsetResourceDirImpl,
        &ContextgetCloudFileDirImpl,
        &ContextsetCloudFileDirImpl,
        &ContextgetEventHubImpl,
        &ContextsetEventHubImpl,
        &ContextgetAreaImpl,
        &ContextsetAreaImpl,
        &ContextgetProcessNameImpl,
        &ContextsetProcessNameImpl,
    };
    return &instance;
}
const OH_CONTEXT_UIAbilityContextModifier* OH_CONTEXT_UIAbilityContextModifierImpl() {
    const static OH_CONTEXT_UIAbilityContextModifier instance = {
        &UIAbilityContext_constructImpl,
        &UIAbilityContext_destructImpl,
        &UIAbilityContext_startAbility0Impl,
        &UIAbilityContext_startAbility1Impl,
        &UIAbilityContext_startAbility2Impl,
        &UIAbilityContext_openLinkImpl,
        &UIAbilityContext_startAbilityAsCaller0Impl,
        &UIAbilityContext_startAbilityAsCaller1Impl,
        &UIAbilityContext_startAbilityAsCaller2Impl,
        &UIAbilityContext_startAbilityByCallImpl,
        &UIAbilityContext_startAbilityByCallWithAccountImpl,
        &UIAbilityContext_startAbilityWithAccount0Impl,
        &UIAbilityContext_startAbilityWithAccount1Impl,
        &UIAbilityContext_startAbilityWithAccount2Impl,
        &UIAbilityContext_startAbilityForResult0Impl,
        &UIAbilityContext_startAbilityForResult1Impl,
        &UIAbilityContext_startAbilityForResult2Impl,
        &UIAbilityContext_startAbilityForResultWithAccount0Impl,
        &UIAbilityContext_startAbilityForResultWithAccount1Impl,
        &UIAbilityContext_startAbilityForResultWithAccount2Impl,
        &UIAbilityContext_startServiceExtensionAbility0Impl,
        &UIAbilityContext_startServiceExtensionAbility1Impl,
        &UIAbilityContext_startServiceExtensionAbilityWithAccount0Impl,
        &UIAbilityContext_startServiceExtensionAbilityWithAccount1Impl,
        &UIAbilityContext_stopServiceExtensionAbility0Impl,
        &UIAbilityContext_stopServiceExtensionAbility1Impl,
        &UIAbilityContext_stopServiceExtensionAbilityWithAccount0Impl,
        &UIAbilityContext_stopServiceExtensionAbilityWithAccount1Impl,
        &UIAbilityContext_terminateSelf0Impl,
        &UIAbilityContext_terminateSelf1Impl,
        &UIAbilityContext_terminateSelfWithResult0Impl,
        &UIAbilityContext_terminateSelfWithResult1Impl,
        &UIAbilityContext_backToCallerAbilityWithResultImpl,
        &UIAbilityContext_connectServiceExtensionAbilityImpl,
        &UIAbilityContext_connectServiceExtensionAbilityWithAccountImpl,
        &UIAbilityContext_disconnectServiceExtensionAbility0Impl,
        &UIAbilityContext_disconnectServiceExtensionAbility1Impl,
        &UIAbilityContext_setMissionLabel0Impl,
        &UIAbilityContext_setMissionLabel1Impl,
        &UIAbilityContext_setMissionIcon0Impl,
        &UIAbilityContext_setMissionIcon1Impl,
        &UIAbilityContext_setMissionContinueState0Impl,
        &UIAbilityContext_setMissionContinueState1Impl,
        &UIAbilityContext_restoreWindowStageImpl,
        &UIAbilityContext_isTerminatingImpl,
        &UIAbilityContext_startRecentAbility0Impl,
        &UIAbilityContext_startRecentAbility1Impl,
        &UIAbilityContext_startRecentAbility2Impl,
        &UIAbilityContext_requestDialogService0Impl,
        &UIAbilityContext_requestDialogService1Impl,
        &UIAbilityContext_reportDrawnCompletedImpl,
        &UIAbilityContext_startAbilityByType0Impl,
        &UIAbilityContext_startAbilityByType1Impl,
        &UIAbilityContext_requestModalUIExtension0Impl,
        &UIAbilityContext_requestModalUIExtension1Impl,
        &UIAbilityContext_openAtomicServiceImpl,
        &UIAbilityContext_moveAbilityToBackgroundImpl,
        &UIAbilityContext_showAbilityImpl,
        &UIAbilityContext_hideAbilityImpl,
        &UIAbilityContext_setRestoreEnabledImpl,
        &UIAbilityContext_startUIServiceExtensionAbilityImpl,
        &UIAbilityContext_connectUIServiceExtensionAbilityImpl,
        &UIAbilityContext_disconnectUIServiceExtensionAbilityImpl,
        &UIAbilityContextgetAbilityInfoImpl,
        &UIAbilityContextsetAbilityInfoImpl,
        &UIAbilityContextgetCurrentHapModuleInfoImpl,
        &UIAbilityContextsetCurrentHapModuleInfoImpl,
        &UIAbilityContextgetConfigImpl,
        &UIAbilityContextsetConfigImpl,
        &UIAbilityContextgetWindowStageImpl,
        &UIAbilityContextsetWindowStageImpl,
    };
    return &instance;
}
const OH_CONTEXT_API* GetCONTEXTAPIImpl(int version) {
    const static OH_CONTEXT_API api = {
        1, // version
        &OH_CONTEXT_ContextModifierImpl,
        &OH_CONTEXT_UIAbilityContextModifierImpl,
    };
    if (version != api.version) return nullptr;
    return &api;
}

// Accessors

OH_NativePointer impl_Context_ctor() {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->construct();
}
KOALA_INTEROP_0(Context_ctor, OH_NativePointer)
OH_NativePointer impl_Context_getFinalizer() {
        return (OH_NativePointer) GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->destruct;
}
KOALA_INTEROP_0(Context_getFinalizer, OH_NativePointer)
OH_NativePointer impl_Context_createBundleContext(OH_NativePointer thisPtr, const KStringPtr& bundleName) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createBundleContext(thisPtr, (const OH_String*) (&bundleName));
}
KOALA_INTEROP_2(Context_createBundleContext, OH_NativePointer, OH_NativePointer, KStringPtr)
OH_NativePointer impl_Context_createModuleContext0(OH_NativePointer thisPtr, const KStringPtr& moduleName) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createModuleContext0(thisPtr, (const OH_String*) (&moduleName));
}
KOALA_INTEROP_2(Context_createModuleContext0, OH_NativePointer, OH_NativePointer, KStringPtr)
OH_NativePointer impl_Context_createModuleContext1(OH_NativePointer thisPtr, const KStringPtr& bundleName, const KStringPtr& moduleName) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createModuleContext1(thisPtr, (const OH_String*) (&bundleName), (const OH_String*) (&moduleName));
}
KOALA_INTEROP_3(Context_createModuleContext1, OH_NativePointer, OH_NativePointer, KStringPtr, KStringPtr)
OH_NativePointer impl_Context_createSystemHspModuleResourceManager(OH_NativePointer thisPtr, const KStringPtr& bundleName, const KStringPtr& moduleName) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createSystemHspModuleResourceManager(thisPtr, (const OH_String*) (&bundleName), (const OH_String*) (&moduleName));
}
KOALA_INTEROP_3(Context_createSystemHspModuleResourceManager, OH_NativePointer, OH_NativePointer, KStringPtr, KStringPtr)
OH_NativePointer impl_Context_getApplicationContext(OH_NativePointer thisPtr) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getApplicationContext(thisPtr);
}
KOALA_INTEROP_1(Context_getApplicationContext, OH_NativePointer, OH_NativePointer)
void impl_Context_getGroupDir0(OH_NativePointer thisPtr, const KStringPtr& dataGroupID, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_AsyncCallback_String_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_String result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_String result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getGroupDir0(thisPtr, (const OH_String*) (&dataGroupID), (const CONTEXT_AsyncCallback_String_Void*)&callback__value);
}
KOALA_INTEROP_V4(Context_getGroupDir0, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_Context_getGroupDir1(OH_NativePointer thisPtr, const KStringPtr& dataGroupID, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_String_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_String value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_String_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_String value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_String_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getGroupDir1(thisPtr, (const OH_String*) (&dataGroupID), (const CONTEXT_Callback_Opt_String_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(Context_getGroupDir1, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
OH_NativePointer impl_Context_createModuleResourceManager(OH_NativePointer thisPtr, const KStringPtr& bundleName, const KStringPtr& moduleName) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createModuleResourceManager(thisPtr, (const OH_String*) (&bundleName), (const OH_String*) (&moduleName));
}
KOALA_INTEROP_3(Context_createModuleResourceManager, OH_NativePointer, OH_NativePointer, KStringPtr, KStringPtr)
OH_NativePointer impl_Context_createAreaModeContext(OH_NativePointer thisPtr, OH_Int32 areaMode) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createAreaModeContext(thisPtr, static_cast<OH_CONTEXT_contextConstant_AreaMode>(areaMode));
}
KOALA_INTEROP_2(Context_createAreaModeContext, OH_NativePointer, OH_NativePointer, OH_Int32)
OH_NativePointer impl_Context_createDisplayContext(OH_NativePointer thisPtr, KInteropNumber displayId) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->createDisplayContext(thisPtr, (const OH_Number*) (&displayId));
}
KOALA_INTEROP_2(Context_createDisplayContext, OH_NativePointer, OH_NativePointer, KInteropNumber)
void impl_Context_setResourceManager(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject resourceManager_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("resmgr.ResourceManager"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setResourceManager(thisPtr, (const OH_CustomObject*)&resourceManager_value);
}
KOALA_INTEROP_V3(Context_setResourceManager, OH_NativePointer, uint8_t*, int32_t)
void impl_Context_setApplicationInfo(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject applicationInfo_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("ApplicationInfo"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setApplicationInfo(thisPtr, (const OH_CustomObject*)&applicationInfo_value);
}
KOALA_INTEROP_V3(Context_setApplicationInfo, OH_NativePointer, uint8_t*, int32_t)
void impl_Context_getCacheDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getCacheDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getCacheDir, OH_NativePointer)
void impl_Context_setCacheDir(OH_NativePointer thisPtr, const KStringPtr& cacheDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setCacheDir(thisPtr, (const OH_String*) (&cacheDir));
}
KOALA_INTEROP_V2(Context_setCacheDir, OH_NativePointer, KStringPtr)
void impl_Context_getTempDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getTempDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getTempDir, OH_NativePointer)
void impl_Context_setTempDir(OH_NativePointer thisPtr, const KStringPtr& tempDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setTempDir(thisPtr, (const OH_String*) (&tempDir));
}
KOALA_INTEROP_V2(Context_setTempDir, OH_NativePointer, KStringPtr)
void impl_Context_getFilesDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getFilesDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getFilesDir, OH_NativePointer)
void impl_Context_setFilesDir(OH_NativePointer thisPtr, const KStringPtr& filesDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setFilesDir(thisPtr, (const OH_String*) (&filesDir));
}
KOALA_INTEROP_V2(Context_setFilesDir, OH_NativePointer, KStringPtr)
void impl_Context_getDatabaseDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getDatabaseDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getDatabaseDir, OH_NativePointer)
void impl_Context_setDatabaseDir(OH_NativePointer thisPtr, const KStringPtr& databaseDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setDatabaseDir(thisPtr, (const OH_String*) (&databaseDir));
}
KOALA_INTEROP_V2(Context_setDatabaseDir, OH_NativePointer, KStringPtr)
void impl_Context_getPreferencesDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getPreferencesDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getPreferencesDir, OH_NativePointer)
void impl_Context_setPreferencesDir(OH_NativePointer thisPtr, const KStringPtr& preferencesDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setPreferencesDir(thisPtr, (const OH_String*) (&preferencesDir));
}
KOALA_INTEROP_V2(Context_setPreferencesDir, OH_NativePointer, KStringPtr)
void impl_Context_getBundleCodeDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getBundleCodeDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getBundleCodeDir, OH_NativePointer)
void impl_Context_setBundleCodeDir(OH_NativePointer thisPtr, const KStringPtr& bundleCodeDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setBundleCodeDir(thisPtr, (const OH_String*) (&bundleCodeDir));
}
KOALA_INTEROP_V2(Context_setBundleCodeDir, OH_NativePointer, KStringPtr)
void impl_Context_getDistributedFilesDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getDistributedFilesDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getDistributedFilesDir, OH_NativePointer)
void impl_Context_setDistributedFilesDir(OH_NativePointer thisPtr, const KStringPtr& distributedFilesDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setDistributedFilesDir(thisPtr, (const OH_String*) (&distributedFilesDir));
}
KOALA_INTEROP_V2(Context_setDistributedFilesDir, OH_NativePointer, KStringPtr)
void impl_Context_getResourceDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getResourceDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getResourceDir, OH_NativePointer)
void impl_Context_setResourceDir(OH_NativePointer thisPtr, const KStringPtr& resourceDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setResourceDir(thisPtr, (const OH_String*) (&resourceDir));
}
KOALA_INTEROP_V2(Context_setResourceDir, OH_NativePointer, KStringPtr)
void impl_Context_getCloudFileDir(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getCloudFileDir(thisPtr);
}
KOALA_INTEROP_V1(Context_getCloudFileDir, OH_NativePointer)
void impl_Context_setCloudFileDir(OH_NativePointer thisPtr, const KStringPtr& cloudFileDir) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setCloudFileDir(thisPtr, (const OH_String*) (&cloudFileDir));
}
KOALA_INTEROP_V2(Context_setCloudFileDir, OH_NativePointer, KStringPtr)
void impl_Context_setEventHub(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject eventHub_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("EventHub"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setEventHub(thisPtr, (const OH_CustomObject*)&eventHub_value);
}
KOALA_INTEROP_V3(Context_setEventHub, OH_NativePointer, uint8_t*, int32_t)
OH_NativePointer impl_Context_getArea(OH_NativePointer thisPtr) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getArea(thisPtr);
}
KOALA_INTEROP_1(Context_getArea, OH_NativePointer, OH_NativePointer)
void impl_Context_setArea(OH_NativePointer thisPtr, OH_Int32 area) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setArea(thisPtr, static_cast<OH_CONTEXT_contextConstant_AreaMode>(area));
}
KOALA_INTEROP_V2(Context_setArea, OH_NativePointer, OH_Int32)
void impl_Context_getProcessName(OH_NativePointer thisPtr) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->getProcessName(thisPtr);
}
KOALA_INTEROP_V1(Context_getProcessName, OH_NativePointer)
void impl_Context_setProcessName(OH_NativePointer thisPtr, const KStringPtr& processName) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->Context()->setProcessName(thisPtr, (const OH_String*) (&processName));
}
KOALA_INTEROP_V2(Context_setProcessName, OH_NativePointer, KStringPtr)
OH_NativePointer impl_UIAbilityContext_ctor() {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->construct();
}
KOALA_INTEROP_0(UIAbilityContext_ctor, OH_NativePointer)
OH_NativePointer impl_UIAbilityContext_getFinalizer() {
        return (OH_NativePointer) GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->destruct;
}
KOALA_INTEROP_0(UIAbilityContext_getFinalizer, OH_NativePointer)
void impl_UIAbilityContext_startAbility0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void startAbilityCallback_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbility0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_Void*)&startAbilityCallback_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbility0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbility1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CONTEXT_StartOptions options_value = thisDeserializer.readStartOptions();;
        CONTEXT_AsyncCallback_Void startAbilityCallback_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbility1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_CONTEXT_StartOptions*)&options_value, (const CONTEXT_AsyncCallback_Void*)&startAbilityCallback_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbility1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbility2(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_StartOptions options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = thisDeserializer.readStartOptions();
        }
        Opt_StartOptions options_value = options_value_buf;;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbility2(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const Opt_StartOptions*)&options_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbility2, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_openLink(OH_NativePointer thisPtr, const KStringPtr& link, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_CustomObject options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("OpenLinkOptions"));
        }
        Opt_CustomObject options_value = options_value_buf;;
        const auto callback__value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_CONTEXT_AsyncCallback_AbilityResult_Void callback__value_buf = {};
        callback__value_buf.tag = callback__value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (callback__value_buf_runtimeType))
        {
            callback__value_buf.value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_AbilityResult_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_AbilityResult_Void))))};
        }
        Opt_CONTEXT_AsyncCallback_AbilityResult_Void callback__value = callback__value_buf;;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->openLink(thisPtr, (const OH_String*) (&link), (const Opt_CustomObject*)&options_value, (const Opt_CONTEXT_AsyncCallback_AbilityResult_Void*)&callback__value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_openLink, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityAsCaller0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityAsCaller0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityAsCaller0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityAsCaller1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CONTEXT_StartOptions options_value = thisDeserializer.readStartOptions();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityAsCaller1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_CONTEXT_StartOptions*)&options_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityAsCaller1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityAsCaller2(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_StartOptions options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = thisDeserializer.readStartOptions();
        }
        Opt_StartOptions options_value = options_value_buf;;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityAsCaller2(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const Opt_StartOptions*)&options_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityAsCaller2, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityByCall(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Caller_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Caller_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityByCall(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityByCall, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityByCallWithAccount(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Caller_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Caller_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityByCallWithAccount(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityByCallWithAccount, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startAbilityWithAccount0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityWithAccount0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityWithAccount0, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startAbilityWithAccount1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CONTEXT_StartOptions options_value = thisDeserializer.readStartOptions();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityWithAccount1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const OH_CONTEXT_StartOptions*)&options_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityWithAccount1, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startAbilityWithAccount2(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_StartOptions options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = thisDeserializer.readStartOptions();
        }
        Opt_StartOptions options_value = options_value_buf;;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityWithAccount2(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const Opt_StartOptions*)&options_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityWithAccount2, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startAbilityForResult0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_AbilityResult_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_AbilityResult_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_AbilityResult_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityForResult0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_AbilityResult_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityForResult0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityForResult1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CONTEXT_StartOptions options_value = thisDeserializer.readStartOptions();;
        CONTEXT_AsyncCallback_AbilityResult_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_AbilityResult_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_AbilityResult_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityForResult1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_CONTEXT_StartOptions*)&options_value, (const CONTEXT_AsyncCallback_AbilityResult_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityForResult1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityForResult2(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_StartOptions options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = thisDeserializer.readStartOptions();
        }
        Opt_StartOptions options_value = options_value_buf;;
        CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityForResult2(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const Opt_StartOptions*)&options_value, (const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startAbilityForResult2, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityForResultWithAccount0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_AbilityResult_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_AbilityResult_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_AbilityResult_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityForResultWithAccount0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_AsyncCallback_AbilityResult_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityForResultWithAccount0, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startAbilityForResultWithAccount1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CONTEXT_StartOptions options_value = thisDeserializer.readStartOptions();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityForResultWithAccount1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const OH_CONTEXT_StartOptions*)&options_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityForResultWithAccount1, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startAbilityForResultWithAccount2(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_StartOptions options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = thisDeserializer.readStartOptions();
        }
        Opt_StartOptions options_value = options_value_buf;;
        CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityForResultWithAccount2(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const Opt_StartOptions*)&options_value, (const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityForResultWithAccount2, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startServiceExtensionAbility0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startServiceExtensionAbility0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startServiceExtensionAbility0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startServiceExtensionAbility1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startServiceExtensionAbility1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startServiceExtensionAbility1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startServiceExtensionAbilityWithAccount0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startServiceExtensionAbilityWithAccount0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_startServiceExtensionAbilityWithAccount0, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_startServiceExtensionAbilityWithAccount1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startServiceExtensionAbilityWithAccount1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_startServiceExtensionAbilityWithAccount1, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_stopServiceExtensionAbility0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->stopServiceExtensionAbility0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_stopServiceExtensionAbility0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_stopServiceExtensionAbility1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->stopServiceExtensionAbility1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_stopServiceExtensionAbility1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_stopServiceExtensionAbilityWithAccount0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->stopServiceExtensionAbilityWithAccount0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_stopServiceExtensionAbilityWithAccount0, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_stopServiceExtensionAbilityWithAccount1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->stopServiceExtensionAbilityWithAccount1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_stopServiceExtensionAbilityWithAccount1, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_terminateSelf0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->terminateSelf0(thisPtr, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_terminateSelf0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_terminateSelf1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->terminateSelf1(thisPtr, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_terminateSelf1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_terminateSelfWithResult0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject parameter_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->terminateSelfWithResult0(thisPtr, (const OH_CustomObject*)&parameter_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_terminateSelfWithResult0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_terminateSelfWithResult1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject parameter_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->terminateSelfWithResult1(thisPtr, (const OH_CustomObject*)&parameter_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_terminateSelfWithResult1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_backToCallerAbilityWithResult(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, const KStringPtr& requestCode) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject abilityResult_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->backToCallerAbilityWithResult(thisPtr, (const OH_CustomObject*)&abilityResult_value, (const OH_String*) (&requestCode), (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_backToCallerAbilityWithResult, OH_NativePointer, uint8_t*, int32_t, KStringPtr)
OH_Int32 impl_UIAbilityContext_connectServiceExtensionAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CustomObject options_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("ConnectOptions"));;
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->connectServiceExtensionAbility(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_CustomObject*)&options_value).i32;
}
KOALA_INTEROP_3(UIAbilityContext_connectServiceExtensionAbility, OH_Int32, OH_NativePointer, uint8_t*, int32_t)
OH_Int32 impl_UIAbilityContext_connectServiceExtensionAbilityWithAccount(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength, KInteropNumber accountId) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CustomObject options_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("ConnectOptions"));;
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->connectServiceExtensionAbilityWithAccount(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_Number*) (&accountId), (const OH_CustomObject*)&options_value).i32;
}
KOALA_INTEROP_4(UIAbilityContext_connectServiceExtensionAbilityWithAccount, OH_Int32, OH_NativePointer, uint8_t*, int32_t, KInteropNumber)
void impl_UIAbilityContext_disconnectServiceExtensionAbility0(OH_NativePointer thisPtr, KInteropNumber connection, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->disconnectServiceExtensionAbility0(thisPtr, (const OH_Number*) (&connection), (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_disconnectServiceExtensionAbility0, OH_NativePointer, KInteropNumber, uint8_t*, int32_t)
void impl_UIAbilityContext_disconnectServiceExtensionAbility1(OH_NativePointer thisPtr, KInteropNumber connection, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->disconnectServiceExtensionAbility1(thisPtr, (const OH_Number*) (&connection), (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_disconnectServiceExtensionAbility1, OH_NativePointer, KInteropNumber, uint8_t*, int32_t)
void impl_UIAbilityContext_setMissionLabel0(OH_NativePointer thisPtr, const KStringPtr& label, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setMissionLabel0(thisPtr, (const OH_String*) (&label), (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_setMissionLabel0, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_UIAbilityContext_setMissionLabel1(OH_NativePointer thisPtr, const KStringPtr& label, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setMissionLabel1(thisPtr, (const OH_String*) (&label), (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_setMissionLabel1, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_UIAbilityContext_setMissionIcon0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject icon_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("image.PixelMap"));;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setMissionIcon0(thisPtr, (const OH_CustomObject*)&icon_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_setMissionIcon0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setMissionIcon1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject icon_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("image.PixelMap"));;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setMissionIcon1(thisPtr, (const OH_CustomObject*)&icon_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_setMissionIcon1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setMissionContinueState0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject state_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityConstant.ContinueState"));;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setMissionContinueState0(thisPtr, (const OH_CustomObject*)&state_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_setMissionContinueState0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setMissionContinueState1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject state_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityConstant.ContinueState"));;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setMissionContinueState1(thisPtr, (const OH_CustomObject*)&state_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_setMissionContinueState1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_restoreWindowStage(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject localStorage_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("LocalStorage"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->restoreWindowStage(thisPtr, (const OH_CustomObject*)&localStorage_value);
}
KOALA_INTEROP_V3(UIAbilityContext_restoreWindowStage, OH_NativePointer, uint8_t*, int32_t)
OH_Boolean impl_UIAbilityContext_isTerminating(OH_NativePointer thisPtr) {
        return GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->isTerminating(thisPtr);
}
KOALA_INTEROP_1(UIAbilityContext_isTerminating, OH_Boolean, OH_NativePointer)
void impl_UIAbilityContext_startRecentAbility0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startRecentAbility0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startRecentAbility0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startRecentAbility1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CONTEXT_StartOptions options_value = thisDeserializer.readStartOptions();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startRecentAbility1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_CONTEXT_StartOptions*)&options_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_startRecentAbility1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startRecentAbility2(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_StartOptions options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = thisDeserializer.readStartOptions();
        }
        Opt_StartOptions options_value = options_value_buf;;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startRecentAbility2(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const Opt_StartOptions*)&options_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startRecentAbility2, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_requestDialogService0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void result_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_dialogRequest_RequestResult_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_dialogRequest_RequestResult_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->requestDialogService0(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void*)&result_value);
}
KOALA_INTEROP_V3(UIAbilityContext_requestDialogService0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_requestDialogService1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->requestDialogService1(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_requestDialogService1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_reportDrawnCompleted(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->reportDrawnCompleted(thisPtr, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_reportDrawnCompleted, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityByType0(OH_NativePointer thisPtr, const KStringPtr& type, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        const OH_Int32 wantParam_value_buf_size = thisDeserializer.readInt32();
        Map_String_CustomObject wantParam_value_buf = {};
        thisDeserializer.resizeMap<Map_String_CustomObject, OH_String, OH_CONTEXT_CustomObject>(&wantParam_value_buf, wantParam_value_buf_size);
        for (int wantParam_value_buf_i = 0; wantParam_value_buf_i < wantParam_value_buf_size; wantParam_value_buf_i++) {
            const OH_String wantParam_value_buf_key = static_cast<OH_String>(thisDeserializer.readString());
            const OH_CONTEXT_CustomObject wantParam_value_buf_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("Object"));
            wantParam_value_buf.keys[wantParam_value_buf_i] = wantParam_value_buf_key;
            wantParam_value_buf.values[wantParam_value_buf_i] = wantParam_value_buf_value;
        }
        Map_String_CustomObject wantParam_value = wantParam_value_buf;;
        OH_CustomObject abilityStartCallback_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityStartCallback"));;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityByType0(thisPtr, (const OH_String*) (&type), (const Map_String_CustomObject*)&wantParam_value, (const OH_CustomObject*)&abilityStartCallback_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityByType0, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_UIAbilityContext_startAbilityByType1(OH_NativePointer thisPtr, const KStringPtr& type, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        const OH_Int32 wantParam_value_buf_size = thisDeserializer.readInt32();
        Map_String_CustomObject wantParam_value_buf = {};
        thisDeserializer.resizeMap<Map_String_CustomObject, OH_String, OH_CONTEXT_CustomObject>(&wantParam_value_buf, wantParam_value_buf_size);
        for (int wantParam_value_buf_i = 0; wantParam_value_buf_i < wantParam_value_buf_size; wantParam_value_buf_i++) {
            const OH_String wantParam_value_buf_key = static_cast<OH_String>(thisDeserializer.readString());
            const OH_CONTEXT_CustomObject wantParam_value_buf_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("Object"));
            wantParam_value_buf.keys[wantParam_value_buf_i] = wantParam_value_buf_key;
            wantParam_value_buf.values[wantParam_value_buf_i] = wantParam_value_buf_value;
        }
        Map_String_CustomObject wantParam_value = wantParam_value_buf;;
        OH_CustomObject abilityStartCallback_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityStartCallback"));;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startAbilityByType1(thisPtr, (const OH_String*) (&type), (const Map_String_CustomObject*)&wantParam_value, (const OH_CustomObject*)&abilityStartCallback_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_startAbilityByType1, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_UIAbilityContext_requestModalUIExtension0(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want pickerWant_value = thisDeserializer.readWant();;
        CONTEXT_AsyncCallback_Void callback__value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_AsyncCallback_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_AsyncCallback_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->requestModalUIExtension0(thisPtr, (const OH_CONTEXT_Want*)&pickerWant_value, (const CONTEXT_AsyncCallback_Void*)&callback__value);
}
KOALA_INTEROP_V3(UIAbilityContext_requestModalUIExtension0, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_requestModalUIExtension1(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want pickerWant_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->requestModalUIExtension1(thisPtr, (const OH_CONTEXT_Want*)&pickerWant_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_requestModalUIExtension1, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_openAtomicService(OH_NativePointer thisPtr, const KStringPtr& appId, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        const auto options_value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
        Opt_CustomObject options_value_buf = {};
        options_value_buf.tag = options_value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
        if ((INTEROP_RUNTIME_UNDEFINED) != (options_value_buf_runtimeType))
        {
            options_value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AtomicServiceOptions"));
        }
        Opt_CustomObject options_value = options_value_buf;;
        CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->openAtomicService(thisPtr, (const OH_String*) (&appId), (const Opt_CustomObject*)&options_value, (const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V4(UIAbilityContext_openAtomicService, OH_NativePointer, KStringPtr, uint8_t*, int32_t)
void impl_UIAbilityContext_moveAbilityToBackground(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->moveAbilityToBackground(thisPtr, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_moveAbilityToBackground, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_showAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->showAbility(thisPtr, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_showAbility, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_hideAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->hideAbility(thisPtr, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_hideAbility, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setRestoreEnabled(OH_NativePointer thisPtr, OH_Boolean enabled) {
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setRestoreEnabled(thisPtr, enabled);
}
KOALA_INTEROP_V2(UIAbilityContext_setRestoreEnabled, OH_NativePointer, OH_Boolean)
void impl_UIAbilityContext_startUIServiceExtensionAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->startUIServiceExtensionAbility(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_startUIServiceExtensionAbility, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_connectUIServiceExtensionAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CONTEXT_Want want_value = thisDeserializer.readWant();;
        OH_CustomObject callback__value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("UIServiceExtensionConnectCallback"));;
        CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->connectUIServiceExtensionAbility(thisPtr, (const OH_CONTEXT_Want*)&want_value, (const OH_CustomObject*)&callback__value, (const CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_connectUIServiceExtensionAbility, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_disconnectUIServiceExtensionAbility(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject proxy_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("UIServiceProxy"));;
        CONTEXT_Callback_Opt_Array_String_Void outputArgumentForReturningPromise_value = {thisDeserializer.readCallbackResource(), reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCaller(Kind_Callback_Opt_Array_String_Void)))), reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointerOrDefault(reinterpret_cast<OH_NativePointer>(getManagedCallbackCallerSync(Kind_Callback_Opt_Array_String_Void))))};;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->disconnectUIServiceExtensionAbility(thisPtr, (const OH_CustomObject*)&proxy_value, (const CONTEXT_Callback_Opt_Array_String_Void*)&outputArgumentForReturningPromise_value);
}
KOALA_INTEROP_V3(UIAbilityContext_disconnectUIServiceExtensionAbility, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setAbilityInfo(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject abilityInfo_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityInfo"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setAbilityInfo(thisPtr, (const OH_CustomObject*)&abilityInfo_value);
}
KOALA_INTEROP_V3(UIAbilityContext_setAbilityInfo, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setCurrentHapModuleInfo(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject currentHapModuleInfo_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("HapModuleInfo"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setCurrentHapModuleInfo(thisPtr, (const OH_CustomObject*)&currentHapModuleInfo_value);
}
KOALA_INTEROP_V3(UIAbilityContext_setCurrentHapModuleInfo, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setConfig(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject config_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("Configuration"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setConfig(thisPtr, (const OH_CustomObject*)&config_value);
}
KOALA_INTEROP_V3(UIAbilityContext_setConfig, OH_NativePointer, uint8_t*, int32_t)
void impl_UIAbilityContext_setWindowStage(OH_NativePointer thisPtr, uint8_t* thisArray, int32_t thisLength) {
        Deserializer thisDeserializer(thisArray, thisLength);
        OH_CustomObject windowStage_value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("window.WindowStage"));;
        GetCONTEXTAPIImpl(CONTEXT_API_VERSION)->UIAbilityContext()->setWindowStage(thisPtr, (const OH_CustomObject*)&windowStage_value);
}
KOALA_INTEROP_V3(UIAbilityContext_setWindowStage, OH_NativePointer, uint8_t*, int32_t)
void deserializeAndCallAsyncCallback_AbilityResult_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    OH_CONTEXT_CustomObject result = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));
    _call(_resourceId, result);
}
void deserializeAndCallSyncAsyncCallback_AbilityResult_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointer());
    OH_CONTEXT_CustomObject result = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));
    _callSync(vmContext, _resourceId, result);
}
void deserializeAndCallAsyncCallback_dialogRequest_RequestResult_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    OH_CONTEXT_CustomObject result = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("dialogRequest.RequestResult"));
    _call(_resourceId, result);
}
void deserializeAndCallSyncAsyncCallback_dialogRequest_RequestResult_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_CustomObject result)>(thisDeserializer.readPointer());
    OH_CONTEXT_CustomObject result = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("dialogRequest.RequestResult"));
    _callSync(vmContext, _resourceId, result);
}
void deserializeAndCallAsyncCallback_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const OH_String result)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    OH_String result = static_cast<OH_String>(thisDeserializer.readString());
    _call(_resourceId, result);
}
void deserializeAndCallSyncAsyncCallback_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const OH_String result)>(thisDeserializer.readPointer());
    OH_String result = static_cast<OH_String>(thisDeserializer.readString());
    _callSync(vmContext, _resourceId, result);
}
void deserializeAndCallAsyncCallback_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    _call(_resourceId);
}
void deserializeAndCallSyncAsyncCallback_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    _callSync(vmContext, _resourceId);
}
void deserializeAndCallCallback_Opt_AbilityResult_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _call(_resourceId, value, error);
}
void deserializeAndCallSyncCallback_Opt_AbilityResult_Opt_Array_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("AbilityResult"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _callSync(vmContext, _resourceId, value, error);
}
void deserializeAndCallCallback_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
void deserializeAndCallSyncCallback_Opt_Array_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
void deserializeAndCallCallback_Opt_Caller_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("Caller"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _call(_resourceId, value, error);
}
void deserializeAndCallSyncCallback_Opt_Caller_Opt_Array_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("Caller"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _callSync(vmContext, _resourceId, value, error);
}
void deserializeAndCallCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("dialogRequest.RequestResult"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _call(_resourceId, value, error);
}
void deserializeAndCallSyncCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("dialogRequest.RequestResult"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _callSync(vmContext, _resourceId, value, error);
}
void deserializeAndCallCallback_Opt_String_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_String value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_String value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_String>(thisDeserializer.readString());
    }
    Opt_String value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _call(_resourceId, value, error);
}
void deserializeAndCallSyncCallback_Opt_String_Opt_Array_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_String value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_String value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_String>(thisDeserializer.readString());
    }
    Opt_String value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _callSync(vmContext, _resourceId, value, error);
}
void deserializeAndCallCallback_Opt_UIServiceProxy_Opt_Array_String_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("UIServiceProxy"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _call(_resourceId, value, error);
}
void deserializeAndCallSyncCallback_Opt_UIServiceProxy_Opt_Array_String_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error)>(thisDeserializer.readPointer());
    const auto value_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
    Opt_CustomObject value_buf = {};
    value_buf.tag = value_buf_runtimeType == INTEROP_RUNTIME_UNDEFINED ? INTEROP_TAG_UNDEFINED : INTEROP_TAG_OBJECT;
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_buf_runtimeType))
    {
        value_buf.value = static_cast<OH_CustomObject>(thisDeserializer.readCustomObject("UIServiceProxy"));
    }
    Opt_CustomObject value = value_buf;
    const auto error_buf_runtimeType = static_cast<OH_CONTEXT_RuntimeType>(thisDeserializer.readInt8());
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
    _callSync(vmContext, _resourceId, value, error);
}
void deserializeAndCallCallback_Void(uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    const auto _call = reinterpret_cast<void(*)(const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    thisDeserializer.readPointer();
    _call(_resourceId);
}
void deserializeAndCallSyncCallback_Void(OH_CONTEXT_VMContext vmContext, uint8_t* thisArray, OH_Int32 thisLength)
{
    Deserializer thisDeserializer = Deserializer(thisArray, thisLength);
    const OH_Int32 _resourceId = thisDeserializer.readInt32();
    thisDeserializer.readPointer();
    const auto _callSync = reinterpret_cast<void(*)(OH_CONTEXT_VMContext vmContext, const OH_Int32 resourceId)>(thisDeserializer.readPointer());
    _callSync(vmContext, _resourceId);
}
void deserializeAndCallCallback(OH_Int32 kind, uint8_t* thisArray, OH_Int32 thisLength)
{
    switch (kind) {
        case 1801791970/*Kind_AsyncCallback_AbilityResult_Void*/: return deserializeAndCallAsyncCallback_AbilityResult_Void(thisArray, thisLength);
        case -1652909257/*Kind_AsyncCallback_dialogRequest_RequestResult_Void*/: return deserializeAndCallAsyncCallback_dialogRequest_RequestResult_Void(thisArray, thisLength);
        case 789188988/*Kind_AsyncCallback_String_Void*/: return deserializeAndCallAsyncCallback_String_Void(thisArray, thisLength);
        case 1075219926/*Kind_AsyncCallback_Void*/: return deserializeAndCallAsyncCallback_Void(thisArray, thisLength);
        case 2092467560/*Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_AbilityResult_Opt_Array_String_Void(thisArray, thisLength);
        case -543655128/*Kind_Callback_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Array_String_Void(thisArray, thisLength);
        case -701632170/*Kind_Callback_Opt_Caller_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_Caller_Opt_Array_String_Void(thisArray, thisLength);
        case 1663507741/*Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(thisArray, thisLength);
        case 1813490422/*Kind_Callback_Opt_String_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_String_Opt_Array_String_Void(thisArray, thisLength);
        case -1175461650/*Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void*/: return deserializeAndCallCallback_Opt_UIServiceProxy_Opt_Array_String_Void(thisArray, thisLength);
        case -1867723152/*Kind_Callback_Void*/: return deserializeAndCallCallback_Void(thisArray, thisLength);
    }
    throw "Unknown callback kind";
}
void deserializeAndCallCallbackSync(OH_CONTEXT_VMContext vmContext, OH_Int32 kind, uint8_t* thisArray, OH_Int32 thisLength)
{
    switch (kind) {
        case 1801791970/*Kind_AsyncCallback_AbilityResult_Void*/: return deserializeAndCallSyncAsyncCallback_AbilityResult_Void(vmContext, thisArray, thisLength);
        case -1652909257/*Kind_AsyncCallback_dialogRequest_RequestResult_Void*/: return deserializeAndCallSyncAsyncCallback_dialogRequest_RequestResult_Void(vmContext, thisArray, thisLength);
        case 789188988/*Kind_AsyncCallback_String_Void*/: return deserializeAndCallSyncAsyncCallback_String_Void(vmContext, thisArray, thisLength);
        case 1075219926/*Kind_AsyncCallback_Void*/: return deserializeAndCallSyncAsyncCallback_Void(vmContext, thisArray, thisLength);
        case 2092467560/*Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_AbilityResult_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case -543655128/*Kind_Callback_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case -701632170/*Kind_Callback_Opt_Caller_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_Caller_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case 1663507741/*Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case 1813490422/*Kind_Callback_Opt_String_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_String_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case -1175461650/*Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void*/: return deserializeAndCallSyncCallback_Opt_UIServiceProxy_Opt_Array_String_Void(vmContext, thisArray, thisLength);
        case -1867723152/*Kind_Callback_Void*/: return deserializeAndCallSyncCallback_Void(vmContext, thisArray, thisLength);
    }
    throw "Unknown callback kind";
}
void callManagedAsyncCallback_AbilityResult_Void(OH_Int32 resourceId, OH_CONTEXT_CustomObject result)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_AsyncCallback_AbilityResult_Void);
    argsSerializer.writeInt32(resourceId);
    argsSerializer.writeCustomObject("AbilityResult", result);
    enqueueCallback(&__buffer);
}
void callManagedAsyncCallback_AbilityResult_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, OH_CONTEXT_CustomObject result)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_AsyncCallback_AbilityResult_Void);
    argsSerializer.writeInt32(resourceId);
    argsSerializer.writeCustomObject("AbilityResult", result);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedAsyncCallback_dialogRequest_RequestResult_Void(OH_Int32 resourceId, OH_CONTEXT_CustomObject result)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_AsyncCallback_dialogRequest_RequestResult_Void);
    argsSerializer.writeInt32(resourceId);
    argsSerializer.writeCustomObject("dialogRequest.RequestResult", result);
    enqueueCallback(&__buffer);
}
void callManagedAsyncCallback_dialogRequest_RequestResult_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, OH_CONTEXT_CustomObject result)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_AsyncCallback_dialogRequest_RequestResult_Void);
    argsSerializer.writeInt32(resourceId);
    argsSerializer.writeCustomObject("dialogRequest.RequestResult", result);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedAsyncCallback_String_Void(OH_Int32 resourceId, OH_String result)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_AsyncCallback_String_Void);
    argsSerializer.writeInt32(resourceId);
    argsSerializer.writeString(result);
    enqueueCallback(&__buffer);
}
void callManagedAsyncCallback_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, OH_String result)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_AsyncCallback_String_Void);
    argsSerializer.writeInt32(resourceId);
    argsSerializer.writeString(result);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedAsyncCallback_Void(OH_Int32 resourceId)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_AsyncCallback_Void);
    argsSerializer.writeInt32(resourceId);
    enqueueCallback(&__buffer);
}
void callManagedAsyncCallback_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_AsyncCallback_Void);
    argsSerializer.writeInt32(resourceId);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Opt_AbilityResult_Opt_Array_String_Void(OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("AbilityResult", value_value);
    }
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
    enqueueCallback(&__buffer);
}
void callManagedCallback_Opt_AbilityResult_Opt_Array_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("AbilityResult", value_value);
    }
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
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Opt_Array_String_Void(OH_Int32 resourceId, Opt_Array_String error)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
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
    enqueueCallback(&__buffer);
}
void callManagedCallback_Opt_Array_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, Opt_Array_String error)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
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
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Opt_Caller_Opt_Array_String_Void(OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Opt_Caller_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("Caller", value_value);
    }
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
    enqueueCallback(&__buffer);
}
void callManagedCallback_Opt_Caller_Opt_Array_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Opt_Caller_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("Caller", value_value);
    }
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
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void(OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("dialogRequest.RequestResult", value_value);
    }
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
    enqueueCallback(&__buffer);
}
void callManagedCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("dialogRequest.RequestResult", value_value);
    }
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
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Opt_String_Opt_Array_String_Void(OH_Int32 resourceId, Opt_String value, Opt_Array_String error)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Opt_String_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeString(value_value);
    }
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
    enqueueCallback(&__buffer);
}
void callManagedCallback_Opt_String_Opt_Array_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, Opt_String value, Opt_Array_String error)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Opt_String_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeString(value_value);
    }
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
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Opt_UIServiceProxy_Opt_Array_String_Void(OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("UIServiceProxy", value_value);
    }
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
    enqueueCallback(&__buffer);
}
void callManagedCallback_Opt_UIServiceProxy_Opt_Array_String_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId, Opt_CustomObject value, Opt_Array_String error)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void);
    argsSerializer.writeInt32(resourceId);
    OH_Int32 value_type = INTEROP_RUNTIME_UNDEFINED;
    value_type = runtimeType(value);
    argsSerializer.writeInt8(value_type);
    if ((INTEROP_RUNTIME_UNDEFINED) != (value_type)) {
        const auto value_value = value.value;
        argsSerializer.writeCustomObject("UIServiceProxy", value_value);
    }
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
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
void callManagedCallback_Void(OH_Int32 resourceId)
{
    CallbackBuffer __buffer = {{}, {}};
    const OH_CONTEXT_CallbackResource __callbackResource = {resourceId, holdManagedCallbackResource, releaseManagedCallbackResource};
    __buffer.resourceHolder.holdCallbackResource(&__callbackResource);
    Serializer argsSerializer = Serializer(__buffer.buffer, sizeof(__buffer.buffer), &(__buffer.resourceHolder));
    argsSerializer.writeInt32(Kind_Callback_Void);
    argsSerializer.writeInt32(resourceId);
    enqueueCallback(&__buffer);
}
void callManagedCallback_VoidSync(OH_CONTEXT_VMContext vmContext, OH_Int32 resourceId)
{
    uint8_t __buffer[60 * 4];
    Serializer argsSerializer = Serializer(__buffer, sizeof(__buffer), nullptr);
    argsSerializer.writeInt32(Kind_Callback_Void);
    argsSerializer.writeInt32(resourceId);
    KOALA_INTEROP_CALL_VOID(vmContext, 1, sizeof(__buffer), __buffer);
}
OH_NativePointer getManagedCallbackCaller(CallbackKind kind)
{
    switch (kind) {
        case Kind_AsyncCallback_AbilityResult_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_AbilityResult_Void);
        case Kind_AsyncCallback_dialogRequest_RequestResult_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_dialogRequest_RequestResult_Void);
        case Kind_AsyncCallback_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_String_Void);
        case Kind_AsyncCallback_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_Void);
        case Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_AbilityResult_Opt_Array_String_Void);
        case Kind_Callback_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_Array_String_Void);
        case Kind_Callback_Opt_Caller_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_Caller_Opt_Array_String_Void);
        case Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void);
        case Kind_Callback_Opt_String_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_String_Opt_Array_String_Void);
        case Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_UIServiceProxy_Opt_Array_String_Void);
        case Kind_Callback_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Void);
    }
    return nullptr;
}
OH_NativePointer getManagedCallbackCallerSync(CallbackKind kind)
{
    switch (kind) {
        case Kind_AsyncCallback_AbilityResult_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_AbilityResult_VoidSync);
        case Kind_AsyncCallback_dialogRequest_RequestResult_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_dialogRequest_RequestResult_VoidSync);
        case Kind_AsyncCallback_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_String_VoidSync);
        case Kind_AsyncCallback_Void: return reinterpret_cast<OH_NativePointer>(callManagedAsyncCallback_VoidSync);
        case Kind_Callback_Opt_AbilityResult_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_AbilityResult_Opt_Array_String_VoidSync);
        case Kind_Callback_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_Array_String_VoidSync);
        case Kind_Callback_Opt_Caller_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_Caller_Opt_Array_String_VoidSync);
        case Kind_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_dialogRequest_RequestResult_Opt_Array_String_VoidSync);
        case Kind_Callback_Opt_String_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_String_Opt_Array_String_VoidSync);
        case Kind_Callback_Opt_UIServiceProxy_Opt_Array_String_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_Opt_UIServiceProxy_Opt_Array_String_VoidSync);
        case Kind_Callback_Void: return reinterpret_cast<OH_NativePointer>(callManagedCallback_VoidSync);
    }
    return nullptr;
}
const OH_AnyAPI* impls[16] = { 0 };


const OH_AnyAPI* GetAnyAPIImpl(int kind, int version) {
    switch (kind) {
        case OH_CONTEXT_API_KIND:
            return reinterpret_cast<const OH_AnyAPI*>(GetCONTEXTAPIImpl(version));
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
