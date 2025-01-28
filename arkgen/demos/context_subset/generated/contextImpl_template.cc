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

#define KOALA_INTEROP_MODULE NotSpecifiedInteropModule
#include "context.h"

OH_CONTEXT_ContextHandle Context_constructImpl() {
    return {};
}
void Context_destructImpl(OH_CONTEXT_ContextHandle thiz) {
}
OH_CONTEXT_Context Context_createBundleContextImpl(OH_NativePointer thisPtr, const OH_String* bundleName) {
    return {};
}
OH_CONTEXT_Context Context_createModuleContext0Impl(OH_NativePointer thisPtr, const OH_String* moduleName) {
    return {};
}
OH_CONTEXT_Context Context_createModuleContext1Impl(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName) {
    return {};
}
OH_CONTEXT_resmgr_ResourceManager Context_createSystemHspModuleResourceManagerImpl(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName) {
    return {};
}
OH_CONTEXT_ApplicationContext Context_getApplicationContextImpl(OH_NativePointer thisPtr) {
    return {};
}
void Context_getGroupDir0Impl(OH_NativePointer thisPtr, const OH_String* dataGroupID, const CONTEXT_AsyncCallback_String_Void* callback_) {
}
void Context_getGroupDir1Impl(OH_NativePointer thisPtr, const OH_String* dataGroupID, const CONTEXT_Callback_Opt_String_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
OH_CONTEXT_resmgr_ResourceManager Context_createModuleResourceManagerImpl(OH_NativePointer thisPtr, const OH_String* bundleName, const OH_String* moduleName) {
    return {};
}
OH_CONTEXT_Context Context_createAreaModeContextImpl(OH_NativePointer thisPtr, const OH_CONTEXT_contextConstant_AreaMode* areaMode) {
    return {};
}
OH_CONTEXT_Context Context_createDisplayContextImpl(OH_NativePointer thisPtr, const OH_Number* displayId) {
    return {};
}
OH_CONTEXT_resmgr_ResourceManager ContextgetResourceManagerImpl(OH_CONTEXT_resmgr_ResourceManager thiz) {
    return {};
}
void ContextsetResourceManagerImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_resmgr_ResourceManager value) {
}
OH_CONTEXT_ApplicationInfo ContextgetApplicationInfoImpl(OH_CONTEXT_ApplicationInfo thiz) {
    return {};
}
void ContextsetApplicationInfoImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_ApplicationInfo value) {
}
OH_String ContextgetCacheDirImpl(OH_String thiz) {
    return {};
}
void ContextsetCacheDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetTempDirImpl(OH_String thiz) {
    return {};
}
void ContextsetTempDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetFilesDirImpl(OH_String thiz) {
    return {};
}
void ContextsetFilesDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetDatabaseDirImpl(OH_String thiz) {
    return {};
}
void ContextsetDatabaseDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetPreferencesDirImpl(OH_String thiz) {
    return {};
}
void ContextsetPreferencesDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetBundleCodeDirImpl(OH_String thiz) {
    return {};
}
void ContextsetBundleCodeDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetDistributedFilesDirImpl(OH_String thiz) {
    return {};
}
void ContextsetDistributedFilesDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetResourceDirImpl(OH_String thiz) {
    return {};
}
void ContextsetResourceDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_String ContextgetCloudFileDirImpl(OH_String thiz) {
    return {};
}
void ContextsetCloudFileDirImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_CONTEXT_EventHub ContextgetEventHubImpl(OH_CONTEXT_EventHub thiz) {
    return {};
}
void ContextsetEventHubImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_EventHub value) {
}
OH_CONTEXT_contextConstant_AreaMode ContextgetAreaImpl(OH_CONTEXT_contextConstant_AreaMode thiz) {
    return {};
}
void ContextsetAreaImpl(OH_CONTEXT_ContextHandle thiz, OH_CONTEXT_contextConstant_AreaMode value) {
}
OH_String ContextgetProcessNameImpl(OH_String thiz) {
    return {};
}
void ContextsetProcessNameImpl(OH_CONTEXT_ContextHandle thiz, OH_String value) {
}
OH_CONTEXT_UIAbilityContextHandle UIAbilityContext_constructImpl() {
    return {};
}
void UIAbilityContext_destructImpl(OH_CONTEXT_UIAbilityContextHandle thiz) {
}
void UIAbilityContext_startAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* startAbilityCallback) {
}
void UIAbilityContext_startAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* startAbilityCallback) {
}
void UIAbilityContext_startAbility2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_openLinkImpl(OH_NativePointer thisPtr, const OH_String* link, const Opt_CustomObject* options, const Opt_CONTEXT_AsyncCallback_AbilityResult_Void* callback_, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startAbilityAsCaller0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityAsCaller1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityAsCaller2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startAbilityByCallImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startAbilityByCallWithAccountImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Caller_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startAbilityWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityWithAccount2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startAbilityForResult0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_) {
}
void UIAbilityContext_startAbilityForResult1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_) {
}
void UIAbilityContext_startAbilityForResult2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startAbilityForResultWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_AbilityResult_Void* callback_) {
}
void UIAbilityContext_startAbilityForResultWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityForResultWithAccount2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startServiceExtensionAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startServiceExtensionAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_startServiceExtensionAbilityWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startServiceExtensionAbilityWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_stopServiceExtensionAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_stopServiceExtensionAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_stopServiceExtensionAbilityWithAccount0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_stopServiceExtensionAbilityWithAccount1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_terminateSelf0Impl(OH_NativePointer thisPtr, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_terminateSelf1Impl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_terminateSelfWithResult0Impl(OH_NativePointer thisPtr, const OH_CustomObject* parameter, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_terminateSelfWithResult1Impl(OH_NativePointer thisPtr, const OH_CustomObject* parameter, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_backToCallerAbilityWithResultImpl(OH_NativePointer thisPtr, const OH_CustomObject* abilityResult, const OH_String* requestCode, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
OH_Number UIAbilityContext_connectServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CustomObject* options) {
    return {};
}
OH_Number UIAbilityContext_connectServiceExtensionAbilityWithAccountImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_Number* accountId, const OH_CustomObject* options) {
    return {};
}
void UIAbilityContext_disconnectServiceExtensionAbility0Impl(OH_NativePointer thisPtr, const OH_Number* connection, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_disconnectServiceExtensionAbility1Impl(OH_NativePointer thisPtr, const OH_Number* connection, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_setMissionLabel0Impl(OH_NativePointer thisPtr, const OH_String* label, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_setMissionLabel1Impl(OH_NativePointer thisPtr, const OH_String* label, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_setMissionIcon0Impl(OH_NativePointer thisPtr, const OH_CustomObject* icon, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_setMissionIcon1Impl(OH_NativePointer thisPtr, const OH_CustomObject* icon, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_setMissionContinueState0Impl(OH_NativePointer thisPtr, const OH_CustomObject* state, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_setMissionContinueState1Impl(OH_NativePointer thisPtr, const OH_CustomObject* state, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_restoreWindowStageImpl(OH_NativePointer thisPtr, const OH_CustomObject* localStorage) {
}
OH_Boolean UIAbilityContext_isTerminatingImpl(OH_NativePointer thisPtr) {
    return {};
}
void UIAbilityContext_startRecentAbility0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startRecentAbility1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CONTEXT_StartOptions* options, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startRecentAbility2Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const Opt_StartOptions* options, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_requestDialogService0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_AsyncCallback_dialogRequest_RequestResult_Void* result) {
}
void UIAbilityContext_requestDialogService1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_dialogRequest_RequestResult_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_reportDrawnCompletedImpl(OH_NativePointer thisPtr, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityByType0Impl(OH_NativePointer thisPtr, const OH_String* type, const Map_String_CustomObject* wantParam, const OH_CustomObject* abilityStartCallback, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_startAbilityByType1Impl(OH_NativePointer thisPtr, const OH_String* type, const Map_String_CustomObject* wantParam, const OH_CustomObject* abilityStartCallback, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_requestModalUIExtension0Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* pickerWant, const CONTEXT_AsyncCallback_Void* callback_) {
}
void UIAbilityContext_requestModalUIExtension1Impl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* pickerWant, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_openAtomicServiceImpl(OH_NativePointer thisPtr, const OH_String* appId, const Opt_CustomObject* options, const CONTEXT_Callback_Opt_AbilityResult_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_moveAbilityToBackgroundImpl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_showAbilityImpl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_hideAbilityImpl(OH_NativePointer thisPtr, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_setRestoreEnabledImpl(OH_NativePointer thisPtr, const OH_Boolean* enabled) {
}
void UIAbilityContext_startUIServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_connectUIServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CONTEXT_Want* want, const OH_CustomObject* callback_, const CONTEXT_Callback_Opt_UIServiceProxy_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
void UIAbilityContext_disconnectUIServiceExtensionAbilityImpl(OH_NativePointer thisPtr, const OH_CustomObject* proxy, const CONTEXT_Callback_Opt_Array_String_Void* outputArgumentForReturningPromise) {
}
OH_CONTEXT_AbilityInfo UIAbilityContextgetAbilityInfoImpl(OH_CONTEXT_AbilityInfo thiz) {
    return {};
}
void UIAbilityContextsetAbilityInfoImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_AbilityInfo value) {
}
OH_CONTEXT_HapModuleInfo UIAbilityContextgetCurrentHapModuleInfoImpl(OH_CONTEXT_HapModuleInfo thiz) {
    return {};
}
void UIAbilityContextsetCurrentHapModuleInfoImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_HapModuleInfo value) {
}
OH_CONTEXT_Configuration UIAbilityContextgetConfigImpl(OH_CONTEXT_Configuration thiz) {
    return {};
}
void UIAbilityContextsetConfigImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_Configuration value) {
}
OH_CONTEXT_window_WindowStage UIAbilityContextgetWindowStageImpl(OH_CONTEXT_window_WindowStage thiz) {
    return {};
}
void UIAbilityContextsetWindowStageImpl(OH_CONTEXT_UIAbilityContextHandle thiz, OH_CONTEXT_window_WindowStage value) {
}