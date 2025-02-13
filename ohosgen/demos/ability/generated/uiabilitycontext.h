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

#ifndef OH_UIAbilityContext_H
#define OH_UIAbilityContext_H

#ifndef _INTEROP_TYPES_H_
#define _INTEROP_TYPES_H_

#include <stdint.h>

#define INTEROP_FATAL(msg, ...) fprintf(stderr, msg "\n", ##__VA_ARGS__); abort();

typedef enum InteropTag
{
  INTEROP_TAG_UNDEFINED = 101,
  INTEROP_TAG_INT32 = 102,
  INTEROP_TAG_FLOAT32 = 103,
  INTEROP_TAG_STRING = 104,
  INTEROP_TAG_LENGTH = 105,
  INTEROP_TAG_RESOURCE = 106,
  INTEROP_TAG_OBJECT = 107,
} InteropTag;

typedef enum InteropRuntimeType
{
  INTEROP_RUNTIME_UNEXPECTED = -1,
  INTEROP_RUNTIME_NUMBER = 1,
  INTEROP_RUNTIME_STRING = 2,
  INTEROP_RUNTIME_OBJECT = 3,
  INTEROP_RUNTIME_BOOLEAN = 4,
  INTEROP_RUNTIME_UNDEFINED = 5,
  INTEROP_RUNTIME_BIGINT = 6,
  INTEROP_RUNTIME_FUNCTION = 7,
  INTEROP_RUNTIME_SYMBOL = 8,
  INTEROP_RUNTIME_MATERIALIZED = 9,
} InteropRuntimeType;

typedef float InteropFloat32;
typedef double InteropFloat64;
typedef int32_t InteropInt32;
typedef unsigned int InteropUInt32; // TODO: update unsigned int
typedef int64_t InteropInt64;
typedef uint64_t InteropUInt64;
typedef int8_t InteropInt8;
typedef uint8_t InteropUInt8;
typedef int64_t InteropDate;
typedef int8_t InteropBoolean;
typedef const char* InteropCharPtr;
typedef void* InteropNativePointer;

struct _InteropVMContext;
typedef struct _InteropVMContext* InteropVMContext;
struct _InteropPipelineContext;
typedef struct _InteropPipelineContext* InteropPipelineContext;
struct _InteropVMObject;
typedef struct _InteropVMObject* InteropVMObject;
struct _InteropNode;
typedef struct _InteropNode* InteropNodeHandle;
typedef struct InteropDeferred {
    void* handler;
    void* context;
    void (*resolve)(struct InteropDeferred* thiz, uint8_t* data, int32_t length);
    void (*reject)(struct InteropDeferred* thiz, const char* message);
} InteropDeferred;

// Binary layout of InteropString must match that of KStringPtrImpl.
typedef struct InteropString {
  const char* chars;
  InteropInt32 length;
} InteropString;

typedef struct InteropEmpty {
  InteropInt32 dummy; // Empty structs are forbidden in C.
} InteropEmpty;

typedef struct InteropNumber {
  InteropInt8 tag;
  union {
    InteropFloat32 f32;
    InteropInt32 i32;
  };
} InteropNumber;

// Binary layout of InteropLength must match that of KLength.
typedef struct InteropLength
{
  InteropInt8 type;
  InteropFloat32 value;
  InteropInt32 unit;
  InteropInt32 resource;
} InteropLength;

typedef struct InteropCustomObject {
  char kind[20];
  InteropInt32 id;
  // Data of custom object.
  union {
    InteropInt32 ints[4];
    InteropFloat32 floats[4];
    void* pointers[4];
    InteropString string;
  };
} InteropCustomObject;

typedef struct InteropUndefined {
  InteropInt32 dummy; // Empty structs are forbidden in C.
} InteropUndefined;

typedef struct InteropVoid {
  InteropInt32 dummy; // Empty structs are forbidden in C.
} InteropVoid;

typedef struct InteropFunction {
  InteropInt32 id;
} InteropFunction;
typedef InteropFunction InteropCallback;
typedef InteropFunction InteropErrorCallback;

typedef struct InteropMaterialized {
  InteropNativePointer ptr;
} InteropMaterialized;

typedef struct InteropCallbackResource {
  InteropInt32 resourceId;
  void (*hold)(InteropInt32 resourceId);
  void (*release)(InteropInt32 resourceId);
} InteropCallbackResource;

typedef struct InteropBuffer {
  InteropCallbackResource resource;
  InteropNativePointer data;
  InteropInt64 length;
} InteropBuffer;

#endif // _INTEROP_TYPES_H_


#define UIAbilityContext_API_VERSION 1

#include <stdint.h>

/* clang-format off */

#ifdef __cplusplus
extern "C" {
#endif

typedef InteropTag OH_Tag;
typedef InteropRuntimeType OH_UIAbilityContext_RuntimeType;

typedef InteropFloat32 OH_Float32;
typedef InteropFloat64 OH_Float64;
typedef InteropInt32 OH_Int32;
typedef InteropUInt32 OH_UInt32;
typedef InteropInt64 OH_Int64;
typedef InteropUInt64 OH_UInt64;
typedef InteropInt8 OH_Int8;
typedef InteropBoolean OH_Boolean;
typedef InteropCharPtr OH_CharPtr;
typedef InteropNativePointer OH_NativePointer;
typedef InteropString OH_String;
typedef InteropCallbackResource OH_UIAbilityContext_CallbackResource;
typedef InteropNumber OH_Number;
typedef InteropMaterialized OH_Materialized;
typedef InteropCustomObject OH_CustomObject;
typedef InteropUndefined OH_Undefined;
// typedef InteropAPIKind OH_APIKind;
typedef InteropVMContext OH_UIAbilityContext_VMContext;
typedef InteropBuffer OH_Buffer;
typedef InteropLength OH_Length;
typedef InteropFunction OH_Function;

typedef enum OH_APIKind {
    OH_UIAbilityContext_API_KIND = 100
} OH_APIKind;

typedef struct OH_AnyAPI {
    OH_Int32 version;
} OH_AnyAPI;

typedef struct Map_String_Number Map_String_Number;
typedef struct Opt_Map_String_Number Opt_Map_String_Number;
typedef struct Array_String Array_String;
typedef struct Opt_Array_String Opt_Array_String;
typedef struct Map_String_CustomObject Map_String_CustomObject;
typedef struct Opt_Map_String_CustomObject Opt_Map_String_CustomObject;
typedef struct UIAbilityContext_AsyncCallback_Void UIAbilityContext_AsyncCallback_Void;
typedef struct Opt_UIAbilityContext_AsyncCallback_Void Opt_UIAbilityContext_AsyncCallback_Void;
typedef struct OH_UIAbilityContext_Want OH_UIAbilityContext_Want;
typedef struct Opt_Want Opt_Want;
typedef struct UIAbilityContext_Callback_Void UIAbilityContext_Callback_Void;
typedef struct Opt_UIAbilityContext_Callback_Void Opt_UIAbilityContext_Callback_Void;
typedef struct UIAbilityContext_Callback_Opt_Array_String_Void UIAbilityContext_Callback_Opt_Array_String_Void;
typedef struct Opt_UIAbilityContext_Callback_Opt_Array_String_Void Opt_UIAbilityContext_Callback_Opt_Array_String_Void;
typedef struct UIAbilityContext_UIAbilityContextPeer UIAbilityContext_UIAbilityContextPeer;
typedef struct UIAbilityContext_UIAbilityContextPeer* OH_UIAbilityContext_UIAbilityContext;
typedef struct Opt_UIAbilityContext Opt_UIAbilityContext;
typedef struct Opt_Int32 {
    OH_Tag tag;
    OH_Int32 value;
} Opt_Int32;
typedef struct Map_String_Number {
    OH_Int32 size;
    OH_String* keys;
    OH_Number* values;
} Map_String_Number;
typedef struct Opt_Map_String_Number {
    OH_Tag tag;
    Map_String_Number value;
} Opt_Map_String_Number;
typedef struct Opt_String {
    OH_Tag tag;
    OH_String value;
} Opt_String;
typedef struct Array_String {
    OH_String* array;
    OH_Int32 length;
} Array_String;
typedef struct Opt_Array_String {
    OH_Tag tag;
    Array_String value;
} Opt_Array_String;
typedef struct Map_String_CustomObject {
    OH_Int32 size;
    OH_String* keys;
    OH_CustomObject* values;
} Map_String_CustomObject;
typedef struct Opt_Map_String_CustomObject {
    OH_Tag tag;
    Map_String_CustomObject value;
} Opt_Map_String_CustomObject;
typedef struct Opt_Number {
    OH_Tag tag;
    OH_Number value;
} Opt_Number;
typedef struct UIAbilityContext_AsyncCallback_Void {
    OH_UIAbilityContext_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId);
    void (*callSync)(OH_UIAbilityContext_VMContext context, const OH_Int32 resourceId);
} UIAbilityContext_AsyncCallback_Void;
typedef struct Opt_UIAbilityContext_AsyncCallback_Void {
    OH_Tag tag;
    UIAbilityContext_AsyncCallback_Void value;
} Opt_UIAbilityContext_AsyncCallback_Void;
typedef struct OH_UIAbilityContext_Want {
    Opt_String bundleName;
    Opt_String abilityName;
    Opt_String deviceId;
    Opt_String uri;
    Opt_String type;
    Opt_Number flags;
    Opt_String action;
    Opt_Map_String_CustomObject parameters;
    Opt_Array_String entities;
    Opt_String moduleName;
    Opt_Map_String_Number fds;
} OH_UIAbilityContext_Want;
typedef struct Opt_Want {
    OH_Tag tag;
    OH_UIAbilityContext_Want value;
} Opt_Want;
typedef struct UIAbilityContext_Callback_Void {
    OH_UIAbilityContext_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId);
    void (*callSync)(OH_UIAbilityContext_VMContext context, const OH_Int32 resourceId);
} UIAbilityContext_Callback_Void;
typedef struct Opt_UIAbilityContext_Callback_Void {
    OH_Tag tag;
    UIAbilityContext_Callback_Void value;
} Opt_UIAbilityContext_Callback_Void;
typedef struct UIAbilityContext_Callback_Opt_Array_String_Void {
    OH_UIAbilityContext_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_Array_String error);
    void (*callSync)(OH_UIAbilityContext_VMContext context, const OH_Int32 resourceId, const Opt_Array_String error);
} UIAbilityContext_Callback_Opt_Array_String_Void;
typedef struct Opt_UIAbilityContext_Callback_Opt_Array_String_Void {
    OH_Tag tag;
    UIAbilityContext_Callback_Opt_Array_String_Void value;
} Opt_UIAbilityContext_Callback_Opt_Array_String_Void;
typedef struct Opt_CustomObject {
    OH_Tag tag;
    OH_CustomObject value;
} Opt_CustomObject;
typedef struct Opt_UIAbilityContext {
    OH_Tag tag;
    OH_UIAbilityContext_UIAbilityContext value;
} Opt_UIAbilityContext;
struct OH_UIAbilityContext_UIAbilityContextHandleOpaque;
typedef struct OH_UIAbilityContext_UIAbilityContextHandleOpaque* OH_UIAbilityContext_UIAbilityContextHandle;
typedef struct OH_UIAbilityContext_UIAbilityContextModifier {
    OH_UIAbilityContext_UIAbilityContextHandle (*construct)();
    void (*destruct)(OH_UIAbilityContext_UIAbilityContextHandle thiz);
    void (*startAbility)(OH_NativePointer thisPtr, const OH_UIAbilityContext_Want* want, const UIAbilityContext_AsyncCallback_Void* callback_);
    void (*terminateSelf0)(OH_NativePointer thisPtr, const UIAbilityContext_AsyncCallback_Void* callback_);
    void (*terminateSelf1)(OH_NativePointer thisPtr, const UIAbilityContext_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
} OH_UIAbilityContext_UIAbilityContextModifier;
typedef struct OH_UIAbilityContext_API {
    OH_Int32 version;
    const OH_UIAbilityContext_UIAbilityContextModifier* (*UIAbilityContext)();
} OH_UIAbilityContext_API;

#ifdef __cplusplus
}  // extern "C"
#endif

#endif // OH_UIAbilityContext_H
/* clang-format on */