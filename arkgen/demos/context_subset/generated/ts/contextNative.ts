import { int32 } from "@koalaui/common"
import { pointer, KPointer, registerNativeModule, registerLoadedLibrary } from "@koalaui/interop"

export enum CallbackKind {
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
}

export class CONTEXTNativeModule {
    static _Context_ctor(): KPointer {
        throw new Error("Not implemented")
    }
    static _Context_getFinalizer(): KPointer {
        throw new Error("Not implemented")
    }
    static _Context_createBundleContext(self: KPointer, bundleName: string): Context {
        throw new Error("Not implemented")
    }
    static _Context_createModuleContext0(self: KPointer, moduleName: string): Context {
        throw new Error("Not implemented")
    }
    static _Context_createModuleContext1(self: KPointer, bundleName: string, moduleName: string): Context {
        throw new Error("Not implemented")
    }
    static _Context_createSystemHspModuleResourceManager(self: KPointer, bundleName: string, moduleName: string): resmgr.ResourceManager {
        throw new Error("Not implemented")
    }
    static _Context_getApplicationContext(self: KPointer): ApplicationContext {
        throw new Error("Not implemented")
    }
    static _Context_getGroupDir0(self: KPointer, dataGroupID: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _Context_getGroupDir1(self: KPointer, dataGroupID: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _Context_createModuleResourceManager(self: KPointer, bundleName: string, moduleName: string): resmgr.ResourceManager {
        throw new Error("Not implemented")
    }
    static _Context_createAreaModeContext(self: KPointer, areaMode: contextConstant.AreaMode): Context {
        throw new Error("Not implemented")
    }
    static _Context_createDisplayContext(self: KPointer, displayId: number): Context {
        throw new Error("Not implemented")
    }
    static _Context_getResourceManager(self: KPointer): resmgr.ResourceManager {
        throw new Error("Not implemented")
    }
    static _Context_setResourceManager(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _Context_getApplicationInfo(self: KPointer): ApplicationInfo {
        throw new Error("Not implemented")
    }
    static _Context_setApplicationInfo(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _Context_getCacheDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setCacheDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getTempDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setTempDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getFilesDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setFilesDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getDatabaseDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setDatabaseDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getPreferencesDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setPreferencesDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getBundleCodeDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setBundleCodeDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getDistributedFilesDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setDistributedFilesDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getResourceDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setResourceDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getCloudFileDir(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setCloudFileDir(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _Context_getEventHub(self: KPointer): EventHub {
        throw new Error("Not implemented")
    }
    static _Context_setEventHub(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _Context_getArea(self: KPointer): contextConstant.AreaMode {
        throw new Error("Not implemented")
    }
    static _Context_setArea(self: KPointer, value: contextConstant.AreaMode): void {
        throw new Error("Not implemented")
    }
    static _Context_getProcessName(self: KPointer): string {
        throw new Error("Not implemented")
    }
    static _Context_setProcessName(self: KPointer, value: string): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_ctor(): KPointer {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_getFinalizer(): KPointer {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbility0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbility1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbility2(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_openLink(self: KPointer, link: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityAsCaller0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityAsCaller1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityAsCaller2(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityByCall(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityByCallWithAccount(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityWithAccount0(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityWithAccount1(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityWithAccount2(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityForResult0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityForResult1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityForResult2(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityForResultWithAccount0(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityForResultWithAccount1(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityForResultWithAccount2(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startServiceExtensionAbility0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startServiceExtensionAbility1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startServiceExtensionAbilityWithAccount0(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startServiceExtensionAbilityWithAccount1(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_stopServiceExtensionAbility0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_stopServiceExtensionAbility1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_stopServiceExtensionAbilityWithAccount0(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_stopServiceExtensionAbilityWithAccount1(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_terminateSelf0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_terminateSelf1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_terminateSelfWithResult0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_terminateSelfWithResult1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_backToCallerAbilityWithResult(self: KPointer, thisArray: Uint8Array, thisLength: int32, requestCode: string): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_connectServiceExtensionAbility(self: KPointer, thisArray: Uint8Array, thisLength: int32): number {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_connectServiceExtensionAbilityWithAccount(self: KPointer, thisArray: Uint8Array, thisLength: int32, accountId: number): number {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_disconnectServiceExtensionAbility0(self: KPointer, connection: number, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_disconnectServiceExtensionAbility1(self: KPointer, connection: number, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setMissionLabel0(self: KPointer, label: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setMissionLabel1(self: KPointer, label: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setMissionIcon0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setMissionIcon1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setMissionContinueState0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setMissionContinueState1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_restoreWindowStage(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_isTerminating(self: KPointer): boolean {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startRecentAbility0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startRecentAbility1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startRecentAbility2(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_requestDialogService0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_requestDialogService1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_reportDrawnCompleted(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityByType0(self: KPointer, type: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startAbilityByType1(self: KPointer, type: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_requestModalUIExtension0(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_requestModalUIExtension1(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_openAtomicService(self: KPointer, appId: string, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_moveAbilityToBackground(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_showAbility(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_hideAbility(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setRestoreEnabled(self: KPointer, enabled: boolean): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_startUIServiceExtensionAbility(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_connectUIServiceExtensionAbility(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_disconnectUIServiceExtensionAbility(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_getAbilityInfo(self: KPointer): AbilityInfo {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setAbilityInfo(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_getCurrentHapModuleInfo(self: KPointer): HapModuleInfo {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setCurrentHapModuleInfo(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_getConfig(self: KPointer): Configuration {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setConfig(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_getWindowStage(self: KPointer): window.WindowStage {
        throw new Error("Not implemented")
    }
    static _UIAbilityContext_setWindowStage(self: KPointer, thisArray: Uint8Array, thisLength: int32): void {
        throw new Error("Not implemented")
    }

    static _MaterializeBuffer(data: KPointer, length: int32, resourceId: int32, holdPtr: KPointer, releasePtr: KPointer): ArrayBuffer {
        throw new Error("Not implemented")
    }
}

registerNativeModule("CONTEXTNativeModule", CONTEXTNativeModule)
declare const LOAD_NATIVE: any
registerLoadedLibrary(LOAD_NATIVE)
