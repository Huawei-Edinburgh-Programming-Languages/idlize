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
#ifndef _INTEROP_TYPES_H_
#define _INTEROP_TYPES_H_

#include <stdint.h>

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


#ifndef OH_CONTEXT_H
#define OH_CONTEXT_H

#define CONTEXT_API_VERSION 1

#include <stdint.h>

/* clang-format off */

#ifdef __cplusplus
extern "C" {
#endif

typedef InteropTag OH_Tag;
typedef InteropRuntimeType OH_CONTEXT_RuntimeType;

typedef InteropFloat32 OH_Float32;
typedef InteropFloat64 OH_Float64;
typedef InteropInt32 OH_Int32;
typedef InteropUInt32 OH_UInt32;
typedef InteropInt64 OH_Int64;
typedef InteropInt8 OH_Int8;
typedef InteropBoolean OH_Boolean;
typedef InteropCharPtr OH_CharPtr;
typedef InteropNativePointer OH_NativePointer;
typedef InteropString OH_String;
typedef InteropCallbackResource OH_CONTEXT_CallbackResource;
typedef InteropNumber OH_Number;
typedef InteropMaterialized OH_Materialized;
typedef InteropCustomObject OH_CustomObject;
typedef InteropUndefined OH_Undefined;
// typedef InteropAPIKind OH_APIKind;
typedef InteropVMContext OH_CONTEXT_VMContext;
typedef InteropBuffer OH_Buffer;
typedef InteropLength OH_Length;
typedef InteropFunction OH_Function;

typedef enum OH_APIKind {
    OH_XML_API_KIND = 100
} OH_APIKind;

typedef struct OH_AnyAPI {
    OH_Int32 version;
} OH_AnyAPI;

typedef struct Array_String Array_String;
typedef struct Opt_Array_String Opt_Array_String;
typedef struct OH_CONTEXT_Literal_Empty OH_CONTEXT_Literal_Empty;
typedef struct Opt_Literal_Empty Opt_Literal_Empty;
typedef struct Array_CustomObject Array_CustomObject;
typedef struct Opt_Array_CustomObject Opt_Array_CustomObject;
typedef struct OH_CONTEXT_Want OH_CONTEXT_Want;
typedef struct Opt_Want Opt_Want;
typedef struct CONTEXT_AsyncCallback_Void CONTEXT_AsyncCallback_Void;
typedef struct Opt_CONTEXT_AsyncCallback_Void Opt_CONTEXT_AsyncCallback_Void;
typedef struct CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void;
typedef struct Opt_CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void Opt_CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void;
typedef struct OH_CONTEXT_StartOptions OH_CONTEXT_StartOptions;
typedef struct Opt_StartOptions Opt_StartOptions;
typedef struct CONTEXT_AsyncCallback_AbilityResult_Void CONTEXT_AsyncCallback_AbilityResult_Void;
typedef struct Opt_CONTEXT_AsyncCallback_AbilityResult_Void Opt_CONTEXT_AsyncCallback_AbilityResult_Void;
typedef struct CONTEXT_AsyncCallback_String_Void CONTEXT_AsyncCallback_String_Void;
typedef struct Opt_CONTEXT_AsyncCallback_String_Void Opt_CONTEXT_AsyncCallback_String_Void;
typedef struct CONTEXT_Callback_Void CONTEXT_Callback_Void;
typedef struct Opt_CONTEXT_Callback_Void Opt_CONTEXT_Callback_Void;
typedef struct CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void Opt_CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_String_Opt_Array_String_Void CONTEXT_Callback_Opt_String_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_String_Opt_Array_String_Void Opt_CONTEXT_Callback_Opt_String_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void Opt_CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void Opt_CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_Array_String_Void CONTEXT_Callback_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_Array_String_Void Opt_CONTEXT_Callback_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void Opt_CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void;
typedef struct OH_CONTEXT_CustomObject OH_CONTEXT_CustomObject;
typedef struct Map_String_CustomObject Map_String_CustomObject;
typedef struct Opt_Map_String_CustomObject Opt_Map_String_CustomObject;
typedef enum OH_CONTEXT_contextConstant_StartupVisibility {
    OH_CONTEXT_CONTEXT_CONSTANT_STARTUP_VISIBILITY_STARTUP_HIDE = 0,
    OH_CONTEXT_CONTEXT_CONSTANT_STARTUP_VISIBILITY_STARTUP_SHOW = 1,
} OH_CONTEXT_contextConstant_StartupVisibility;
typedef struct Opt_contextConstant_StartupVisibility {
    OH_Tag tag;
    OH_CONTEXT_contextConstant_StartupVisibility value;
} Opt_contextConstant_StartupVisibility;
typedef enum OH_CONTEXT_contextConstant_ProcessMode {
    OH_CONTEXT_CONTEXT_CONSTANT_PROCESS_MODE_NEW_PROCESS_ATTACH_TO_PARENT = 1,
    OH_CONTEXT_CONTEXT_CONSTANT_PROCESS_MODE_NEW_PROCESS_ATTACH_TO_STATUS_BAR_ITEM = 2,
    OH_CONTEXT_CONTEXT_CONSTANT_PROCESS_MODE_ATTACH_TO_STATUS_BAR_ITEM = 3,
} OH_CONTEXT_contextConstant_ProcessMode;
typedef struct Opt_contextConstant_ProcessMode {
    OH_Tag tag;
    OH_CONTEXT_contextConstant_ProcessMode value;
} Opt_contextConstant_ProcessMode;
typedef enum OH_CONTEXT_contextConstant_AreaMode {
    OH_CONTEXT_CONTEXT_CONSTANT_AREA_MODE_EL1 = 0,
    OH_CONTEXT_CONTEXT_CONSTANT_AREA_MODE_EL2 = 1,
    OH_CONTEXT_CONTEXT_CONSTANT_AREA_MODE_EL3 = 2,
    OH_CONTEXT_CONTEXT_CONSTANT_AREA_MODE_EL4 = 3,
    OH_CONTEXT_CONTEXT_CONSTANT_AREA_MODE_EL5 = 4,
} OH_CONTEXT_contextConstant_AreaMode;
typedef struct Opt_contextConstant_AreaMode {
    OH_Tag tag;
    OH_CONTEXT_contextConstant_AreaMode value;
} Opt_contextConstant_AreaMode;
typedef struct Opt_Int32 {
    OH_Tag tag;
    OH_Int32 value;
} Opt_Int32;
typedef struct Array_String {
    OH_String* array;
    OH_Int32 length;
} Array_String;
typedef struct Opt_Array_String {
    OH_Tag tag;
    Array_String value;
} Opt_Array_String;
typedef struct OH_CONTEXT_Literal_Empty {
    void *handle;
} OH_CONTEXT_Literal_Empty;
typedef struct Opt_Literal_Empty {
    OH_Tag tag;
    OH_CONTEXT_Literal_Empty value;
} Opt_Literal_Empty;
typedef struct Opt_String {
    OH_Tag tag;
    OH_String value;
} Opt_String;
typedef struct Opt_Number {
    OH_Tag tag;
    OH_Number value;
} Opt_Number;
typedef struct Array_CustomObject {
    OH_CONTEXT_CustomObject* array;
    OH_Int32 length;
} Array_CustomObject;
typedef struct Opt_Array_CustomObject {
    OH_Tag tag;
    Array_CustomObject value;
} Opt_Array_CustomObject;
typedef struct Opt_CustomObject {
    OH_Tag tag;
    OH_CustomObject value;
} Opt_CustomObject;
typedef struct Opt_Boolean {
    OH_Tag tag;
    OH_Boolean value;
} Opt_Boolean;
typedef struct OH_CONTEXT_Want {
    Opt_String deviceId;
    Opt_String bundleName;
    Opt_String abilityName;
    Opt_String uri;
    Opt_String type;
    Opt_Number flags;
    Opt_String action;
    Opt_Literal_Empty parameters;
    Opt_Array_String entities;
} OH_CONTEXT_Want;
typedef struct Opt_Want {
    OH_Tag tag;
    OH_CONTEXT_Want value;
} Opt_Want;
typedef struct CONTEXT_AsyncCallback_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId);
} CONTEXT_AsyncCallback_Void;
typedef struct Opt_CONTEXT_AsyncCallback_Void {
    OH_Tag tag;
    CONTEXT_AsyncCallback_Void value;
} Opt_CONTEXT_AsyncCallback_Void;
typedef struct CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const OH_CustomObject result);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const OH_CustomObject result);
} CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void;
typedef struct Opt_CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void {
    OH_Tag tag;
    CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void value;
} Opt_CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void;
typedef struct OH_CONTEXT_StartOptions {
    Opt_Number windowMode;
    Opt_Number displayId;
    Opt_Boolean withAnimation;
    Opt_Number windowLeft;
    Opt_Number windowTop;
    Opt_Number windowWidth;
    Opt_Number windowHeight;
    Opt_Boolean windowFocused;
    Opt_contextConstant_ProcessMode processMode;
    Opt_contextConstant_StartupVisibility startupVisibility;
    Opt_CustomObject startWindowIcon;
    Opt_String startWindowBackgroundColor;
    Opt_Array_CustomObject supportWindowModes;
} OH_CONTEXT_StartOptions;
typedef struct Opt_StartOptions {
    OH_Tag tag;
    OH_CONTEXT_StartOptions value;
} Opt_StartOptions;
typedef struct CONTEXT_AsyncCallback_AbilityResult_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const OH_CustomObject result);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const OH_CustomObject result);
} CONTEXT_AsyncCallback_AbilityResult_Void;
typedef struct Opt_CONTEXT_AsyncCallback_AbilityResult_Void {
    OH_Tag tag;
    CONTEXT_AsyncCallback_AbilityResult_Void value;
} Opt_CONTEXT_AsyncCallback_AbilityResult_Void;
typedef struct CONTEXT_AsyncCallback_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const OH_String result);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const OH_String result);
} CONTEXT_AsyncCallback_String_Void;
typedef struct Opt_CONTEXT_AsyncCallback_String_Void {
    OH_Tag tag;
    CONTEXT_AsyncCallback_String_Void value;
} Opt_CONTEXT_AsyncCallback_String_Void;
typedef struct CONTEXT_Callback_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId);
} CONTEXT_Callback_Void;
typedef struct Opt_CONTEXT_Callback_Void {
    OH_Tag tag;
    CONTEXT_Callback_Void value;
} Opt_CONTEXT_Callback_Void;
typedef struct CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
} CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void {
    OH_Tag tag;
    CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void value;
} Opt_CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_String_Opt_Array_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_String value, const Opt_Array_String error);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const Opt_String value, const Opt_Array_String error);
} CONTEXT_Callback_Opt_String_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_String_Opt_Array_String_Void {
    OH_Tag tag;
    CONTEXT_Callback_Opt_String_Opt_Array_String_Void value;
} Opt_CONTEXT_Callback_Opt_String_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
} CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void {
    OH_Tag tag;
    CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void value;
} Opt_CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
} CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void {
    OH_Tag tag;
    CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void value;
} Opt_CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_Array_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_Array_String error);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const Opt_Array_String error);
} CONTEXT_Callback_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_Array_String_Void {
    OH_Tag tag;
    CONTEXT_Callback_Opt_Array_String_Void value;
} Opt_CONTEXT_Callback_Opt_Array_String_Void;
typedef struct CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void {
    OH_CONTEXT_CallbackResource resource;
    void (*call)(const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
    void (*callSync)(OH_CONTEXT_VMContext context, const OH_Int32 resourceId, const Opt_CustomObject value, const Opt_Array_String error);
} CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void;
typedef struct Opt_CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void {
    OH_Tag tag;
    CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void value;
} Opt_CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void;
typedef struct OH_CONTEXT_CustomObject {
} OH_CONTEXT_CustomObject;
typedef struct Map_String_CustomObject {
    OH_Int32 size;
    OH_String* keys;
    OH_CONTEXT_CustomObject* values;
} Map_String_CustomObject;
typedef struct Opt_Map_String_CustomObject {
    OH_Tag tag;
    Map_String_CustomObject value;
} Opt_Map_String_CustomObject;
struct OH_CONTEXT_ContextHandleOpaque;
typedef struct OH_CONTEXT_ContextHandleOpaque* OH_CONTEXT_ContextHandle;
typedef struct OH_CONTEXT_ContextModifier {
    OH_CONTEXT_ContextHandle (*construct)();
    void (*destruct)(OH_CONTEXT_ContextHandle thiz);
    OH_CONTEXT_Context (*createBundleContext)(OH_NativePointer thisPtr, const OH_String* bundleName);
    OH_CONTEXT_Context (*createModuleContext0)(OH_NativePointer thisPtr, const OH_String* moduleName);
    OH_CONTEXT_Context (*createModuleContext1)(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName);
    OH_CONTEXT_resmgr_ResourceManager (*createSystemHspModuleResourceManager)(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName);
    OH_CONTEXT_ApplicationContext (*getApplicationContext)(OH_NativePointer thisPtr);
    void (*getGroupDir0)(OH_NativePointer thisPtr, const OH_String* dataGroupID, const CONTEXT_AsyncCallback_String_Void* callback_);
    void (*getGroupDir1)(OH_NativePointer thisPtr, const OH_String* dataGroupID, const CONTEXT_Callback_Opt_String_Opt_Array_String_Void* outputArgumentForReturningPromise);
    OH_CONTEXT_resmgr_ResourceManager (*createModuleResourceManager)(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName);
    OH_CONTEXT_Context (*createAreaModeContext)(OH_NativePointer thisPtr, const OH_CONTEXT_contextConstant_AreaMode* areaMode);
    OH_CONTEXT_Context (*createDisplayContext)(OH_NativePointer thisPtr, const OH_Number* displayId);
    OH_CONTEXT_resmgr_ResourceManager (*getResourceManager)(OH_CONTEXT_ContextHandle thiz);
    void (*setResourceManager)(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_resmgr_ResourceManager value);
    OH_CONTEXT_ApplicationInfo (*getApplicationInfo)(OH_CONTEXT_ContextHandle thiz);
    void (*setApplicationInfo)(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_ApplicationInfo value);
    OH_String (*getCacheDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setCacheDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getTempDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setTempDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getFilesDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setFilesDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getDatabaseDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setDatabaseDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getPreferencesDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setPreferencesDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getBundleCodeDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setBundleCodeDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getDistributedFilesDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setDistributedFilesDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getResourceDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setResourceDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_String (*getCloudFileDir)(OH_CONTEXT_ContextHandle thiz);
    void (*setCloudFileDir)(OH_CONTEXT_ContextHandle thiz, OH_String value);
    OH_CONTEXT_EventHub (*getEventHub)(OH_CONTEXT_ContextHandle thiz);
    void (*setEventHub)(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_EventHub value);
    OH_CONTEXT_contextConstant_AreaMode (*getArea)(OH_CONTEXT_ContextHandle thiz);
    void (*setArea)(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_contextConstant_AreaMode value);
    OH_String (*getProcessName)(OH_CONTEXT_ContextHandle thiz);
    void (*setProcessName)(OH_CONTEXT_ContextHandle thiz, OH_String value);
} OH_CONTEXT_ContextModifier;
struct OH_CONTEXT_UIAbilityContextHandleOpaque;
typedef struct OH_CONTEXT_UIAbilityContextHandleOpaque* OH_CONTEXT_UIAbilityContextHandle;
typedef struct OH_CONTEXT_UIAbilityContextModifier {
    OH_CONTEXT_UIAbilityContextHandle (*construct)();
    void (*destruct)(OH_CONTEXT_UIAbilityContextHandle thiz);
    void (*startAbility0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* startAbilityCallback);
    void (*startAbility1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* startAbilityCallback);
    void (*startAbility2)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*openLink)(OH_NativePointer thisPtr, const OH_String* link, const Opt_CustomObject* options, const Opt_CONTEXT_AsyncCallback_AbilityResult_Void* callback_, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startAbilityAsCaller0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityAsCaller1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityAsCaller2)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startAbilityByCall)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startAbilityByCallWithAccount)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startAbilityWithAccount0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityWithAccount1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityWithAccount2)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startAbilityForResult0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_);
    void (*startAbilityForResult1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_);
    void (*startAbilityForResult2)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startAbilityForResultWithAccount0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_);
    void (*startAbilityForResultWithAccount1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityForResultWithAccount2)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startServiceExtensionAbility0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startServiceExtensionAbility1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*startServiceExtensionAbilityWithAccount0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startServiceExtensionAbilityWithAccount1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*stopServiceExtensionAbility0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
    void (*stopServiceExtensionAbility1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*stopServiceExtensionAbilityWithAccount0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_);
    void (*stopServiceExtensionAbilityWithAccount1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*terminateSelf0)(OH_NativePointer thisPtr, const CONTEXT_AsyncCallback_Void* callback_);
    void (*terminateSelf1)(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*terminateSelfWithResult0)(OH_NativePointer thisPtr, const OH_CustomObject* parameter, const CONTEXT_AsyncCallback_Void* callback_);
    void (*terminateSelfWithResult1)(OH_NativePointer thisPtr, const OH_CustomObject* parameter, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*backToCallerAbilityWithResult)(OH_NativePointer thisPtr, const OH_CustomObject* abilityResult, const OH_String* requestCode, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    OH_Number (*connectServiceExtensionAbility)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CustomObject* options);
    OH_Number (*connectServiceExtensionAbilityWithAccount)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CustomObject* options);
    void (*disconnectServiceExtensionAbility0)(OH_NativePointer thisPtr, const OH_Number* connection, const CONTEXT_AsyncCallback_Void* callback_);
    void (*disconnectServiceExtensionAbility1)(OH_NativePointer thisPtr, const OH_Number* connection, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*setMissionLabel0)(OH_NativePointer thisPtr, const OH_String* label, const CONTEXT_AsyncCallback_Void* callback_);
    void (*setMissionLabel1)(OH_NativePointer thisPtr, const OH_String* label, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*setMissionIcon0)(OH_NativePointer thisPtr, const OH_CustomObject* icon, const CONTEXT_AsyncCallback_Void* callback_);
    void (*setMissionIcon1)(OH_NativePointer thisPtr, const OH_CustomObject* icon, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*setMissionContinueState0)(OH_NativePointer thisPtr, const OH_CustomObject* state, const CONTEXT_AsyncCallback_Void* callback_);
    void (*setMissionContinueState1)(OH_NativePointer thisPtr, const OH_CustomObject* state, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*restoreWindowStage)(OH_NativePointer thisPtr, const OH_CustomObject* localStorage);
    OH_Boolean (*isTerminating)(OH_NativePointer thisPtr);
    void (*startRecentAbility0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startRecentAbility1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startRecentAbility2)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*requestDialogService0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void* result);
    void (*requestDialogService1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*reportDrawnCompleted)(OH_NativePointer thisPtr, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityByType0)(OH_NativePointer thisPtr, const OH_String* type, const Map_String_CustomObject* wantParam, const OH_CustomObject* abilityStartCallback, const CONTEXT_AsyncCallback_Void* callback_);
    void (*startAbilityByType1)(OH_NativePointer thisPtr, const OH_String* type, const Map_String_CustomObject* wantParam, const OH_CustomObject* abilityStartCallback, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*requestModalUIExtension0)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* pickerWant, const CONTEXT_AsyncCallback_Void* callback_);
    void (*requestModalUIExtension1)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* pickerWant, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*openAtomicService)(OH_NativePointer thisPtr, const OH_String* appId, const Opt_CustomObject* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*moveAbilityToBackground)(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*showAbility)(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*hideAbility)(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*setRestoreEnabled)(OH_NativePointer thisPtr, const OH_Boolean* enabled);
    void (*startUIServiceExtensionAbility)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*connectUIServiceExtensionAbility)(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CustomObject* callback_, const CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void* outputArgumentForReturningPromise);
    void (*disconnectUIServiceExtensionAbility)(OH_NativePointer thisPtr, const OH_CustomObject* proxy, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise);
    OH_CONTEXT_AbilityInfo (*getAbilityInfo)(OH_CONTEXT_UIAbilityContextHandle thiz);
    void (*setAbilityInfo)(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_AbilityInfo value);
    OH_CONTEXT_HapModuleInfo (*getCurrentHapModuleInfo)(OH_CONTEXT_UIAbilityContextHandle thiz);
    void (*setCurrentHapModuleInfo)(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_HapModuleInfo value);
    OH_CONTEXT_Configuration (*getConfig)(OH_CONTEXT_UIAbilityContextHandle thiz);
    void (*setConfig)(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_Configuration value);
    OH_CONTEXT_window_WindowStage (*getWindowStage)(OH_CONTEXT_UIAbilityContextHandle thiz);
    void (*setWindowStage)(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_window_WindowStage value);
} OH_CONTEXT_UIAbilityContextModifier;
typedef struct OH_CONTEXT_API {
    OH_Int32 version;
    const OH_CONTEXT_ContextModifier* (*Context)();
    const OH_CONTEXT_UIAbilityContextModifier* (*UIAbilityContext)();
} OH_CONTEXT_API;

#ifdef __cplusplus
}  // extern "C"
#endif

#endif // OH_CONTEXT_H
/* clang-format on */