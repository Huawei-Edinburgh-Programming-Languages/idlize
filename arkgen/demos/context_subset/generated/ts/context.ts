import { int32 } from "@koalaui/common"
import { KPointer, pointer, RuntimeType, runtimeType, unsafeCast } from "@koalaui/interop"
import { Serializer } from "./contextSerializer"
import { Finalizable } from "./contextFinalizable"

import { TypeChecker } from "./type_check"
import {
    CONTEXTNativeModule,
} from './contextNative'
export class StartOptions {
    windowMode?: number
    displayId?: number
    withAnimation?: boolean
    windowLeft?: number
    windowTop?: number
    windowWidth?: number
    windowHeight?: number
    windowFocused?: boolean
    processMode?: contextConstant.ProcessMode
    startupVisibility?: contextConstant.StartupVisibility
    startWindowIcon?: image.PixelMap
    startWindowBackgroundColor?: string
    supportWindowModes?: Array<bundleManager.SupportWindowMode>
}
export class Want {
    deviceId?: string
    bundleName?: string
    abilityName?: string
    uri?: string
    type?: string
    flags?: number
    action?: string
    parameters?: {  }
    entities?: Array<string>
}
export interface ContextInterface extends BaseContextInterface {
    resourceManager: resmgr.ResourceManager
    applicationInfo: ApplicationInfo
    cacheDir: string
    tempDir: string
    filesDir: string
    databaseDir: string
    preferencesDir: string
    bundleCodeDir: string
    distributedFilesDir: string
    resourceDir: string
    cloudFileDir: string
    eventHub: EventHub
    area: contextConstant.AreaMode
    processName: string
    createBundleContext(bundleName: string): Context 
    createModuleContext(moduleName: string): Context 
    createModuleContext(bundleName: string, moduleName: string): Context 
    createSystemHspModuleResourceManager(bundleName: string, moduleName: string): resmgr.ResourceManager 
    getApplicationContext(): ApplicationContext 
    getGroupDir(dataGroupID: string, callback_: ((result: string) => void)): void 
    getGroupDir(dataGroupID: string): Promise<string> 
    createModuleResourceManager(bundleName: string, moduleName: string): resmgr.ResourceManager 
    createAreaModeContext(areaMode: contextConstant.AreaMode): Context 
    createDisplayContext(displayId: number): Context 
}
export interface UIAbilityContextInterface extends ContextInterface {
    abilityInfo: AbilityInfo
    currentHapModuleInfo: HapModuleInfo
    config: Configuration
    windowStage: window.WindowStage
    startAbility(want: Want, startAbilityCallback: (() => void)): void 
    startAbility(want: Want, options: StartOptions, startAbilityCallback: (() => void)): void 
    startAbility(want: Want, options?: StartOptions): Promise<void> 
    openLink(link: string, options?: OpenLinkOptions, callback_?: ((result: AbilityResult) => void)): Promise<void> 
    startAbilityAsCaller(want: Want, callback_: (() => void)): void 
    startAbilityAsCaller(want: Want, options: StartOptions, callback_: (() => void)): void 
    startAbilityAsCaller(want: Want, options?: StartOptions): Promise<void> 
    startAbilityByCall(want: Want): Promise<Caller> 
    startAbilityByCallWithAccount(want: Want, accountId: number): Promise<Caller> 
    startAbilityWithAccount(want: Want, accountId: number, callback_: (() => void)): void 
    startAbilityWithAccount(want: Want, accountId: number, options: StartOptions, callback_: (() => void)): void 
    startAbilityWithAccount(want: Want, accountId: number, options?: StartOptions): Promise<void> 
    startAbilityForResult(want: Want, callback_: ((result: AbilityResult) => void)): void 
    startAbilityForResult(want: Want, options: StartOptions, callback_: ((result: AbilityResult) => void)): void 
    startAbilityForResult(want: Want, options?: StartOptions): Promise<AbilityResult> 
    startAbilityForResultWithAccount(want: Want, accountId: number, callback_: ((result: AbilityResult) => void)): void 
    startAbilityForResultWithAccount(want: Want, accountId: number, options: StartOptions, callback_: (() => void)): void 
    startAbilityForResultWithAccount(want: Want, accountId: number, options?: StartOptions): Promise<AbilityResult> 
    startServiceExtensionAbility(want: Want, callback_: (() => void)): void 
    startServiceExtensionAbility(want: Want): Promise<void> 
    startServiceExtensionAbilityWithAccount(want: Want, accountId: number, callback_: (() => void)): void 
    startServiceExtensionAbilityWithAccount(want: Want, accountId: number): Promise<void> 
    stopServiceExtensionAbility(want: Want, callback_: (() => void)): void 
    stopServiceExtensionAbility(want: Want): Promise<void> 
    stopServiceExtensionAbilityWithAccount(want: Want, accountId: number, callback_: (() => void)): void 
    stopServiceExtensionAbilityWithAccount(want: Want, accountId: number): Promise<void> 
    terminateSelf(callback_: (() => void)): void 
    terminateSelf(): Promise<void> 
    terminateSelfWithResult(parameter: AbilityResult, callback_: (() => void)): void 
    terminateSelfWithResult(parameter: AbilityResult): Promise<void> 
    backToCallerAbilityWithResult(abilityResult: AbilityResult, requestCode: string): Promise<void> 
    connectServiceExtensionAbility(want: Want, options: ConnectOptions): number 
    connectServiceExtensionAbilityWithAccount(want: Want, accountId: number, options: ConnectOptions): number 
    disconnectServiceExtensionAbility(connection: number, callback_: (() => void)): void 
    disconnectServiceExtensionAbility(connection: number): Promise<void> 
    setMissionLabel(label: string, callback_: (() => void)): void 
    setMissionLabel(label: string): Promise<void> 
    setMissionIcon(icon: image.PixelMap, callback_: (() => void)): void 
    setMissionIcon(icon: image.PixelMap): Promise<void> 
    setMissionContinueState(state: AbilityConstant.ContinueState, callback_: (() => void)): void 
    setMissionContinueState(state: AbilityConstant.ContinueState): Promise<void> 
    restoreWindowStage(localStorage: LocalStorage): void 
    isTerminating(): boolean 
    startRecentAbility(want: Want, callback_: (() => void)): void 
    startRecentAbility(want: Want, options: StartOptions, callback_: (() => void)): void 
    startRecentAbility(want: Want, options?: StartOptions): Promise<void> 
    requestDialogService(want: Want, result: ((result: dialogRequest.RequestResult) => void)): void 
    requestDialogService(want: Want): Promise<dialogRequest.RequestResult> 
    reportDrawnCompleted(callback_: (() => void)): void 
    startAbilityByType(type: string, wantParam: Map<string, Object>, abilityStartCallback: AbilityStartCallback, callback_: (() => void)): void 
    startAbilityByType(type: string, wantParam: Map<string, Object>, abilityStartCallback: AbilityStartCallback): Promise<void> 
    requestModalUIExtension(pickerWant: Want, callback_: (() => void)): void 
    requestModalUIExtension(pickerWant: Want): Promise<void> 
    openAtomicService(appId: string, options?: AtomicServiceOptions): Promise<AbilityResult> 
    moveAbilityToBackground(): Promise<void> 
    showAbility(): Promise<void> 
    hideAbility(): Promise<void> 
    setRestoreEnabled(enabled: boolean): void 
    startUIServiceExtensionAbility(want: Want): Promise<void> 
    connectUIServiceExtensionAbility(want: Want, callback_: UIServiceExtensionConnectCallback): Promise<UIServiceProxy> 
    disconnectUIServiceExtensionAbility(proxy: UIServiceProxy): Promise<void> 
}
export interface StartOptionsInterface {
    windowMode: number
    displayId: number
    withAnimation: boolean
    windowLeft: number
    windowTop: number
    windowWidth: number
    windowHeight: number
    windowFocused: boolean
    processMode: contextConstant.ProcessMode
    startupVisibility: contextConstant.StartupVisibility
    startWindowIcon: image.PixelMap
    startWindowBackgroundColor: string
    supportWindowModes: Array<bundleManager.SupportWindowMode>
}
export interface Literal_EmptyInterface {
    indexSignature(key: string): any 
}
export interface WantInterface {
    deviceId: string
    bundleName: string
    abilityName: string
    uri: string
    type: string
    flags: number
    action: string
    parameters: {  }
    entities: Array<string>
}
export namespace contextConstant {
    export enum AreaMode {
        EL1,
        EL2 = 1,
        EL3 = 2,
        EL4 = 3,
        EL5 = 4,
    }
}
export namespace contextConstant {
    export enum ProcessMode {
        NEW_PROCESS_ATTACH_TO_PARENT = 1,
        NEW_PROCESS_ATTACH_TO_STATUS_BAR_ITEM = 2,
        ATTACH_TO_STATUS_BAR_ITEM = 3,
    }
}
export namespace contextConstant {
    export enum StartupVisibility {
        STARTUP_HIDE,
        STARTUP_SHOW = 1,
    }
}
export class Context extends BaseContext implements ContextInterface {
    peer: Finalizable
    getResourceManager(): resmgr.ResourceManager {
        return CONTEXTNativeModule._Context_getResourceManager(this.peer!.ptr)
    }
    setResourceManager(resourceManager: resmgr.ResourceManager): void {
        CONTEXTNativeModule._Context_setResourceManager(this.peer!.ptr, resourceManager)
    }
    getApplicationInfo(): ApplicationInfo {
        return CONTEXTNativeModule._Context_getApplicationInfo(this.peer!.ptr)
    }
    setApplicationInfo(applicationInfo: ApplicationInfo): void {
        CONTEXTNativeModule._Context_setApplicationInfo(this.peer!.ptr, applicationInfo)
    }
    getCacheDir(): string {
        return CONTEXTNativeModule._Context_getCacheDir(this.peer!.ptr)
    }
    setCacheDir(cacheDir: string): void {
        CONTEXTNativeModule._Context_setCacheDir(this.peer!.ptr, cacheDir)
    }
    getTempDir(): string {
        return CONTEXTNativeModule._Context_getTempDir(this.peer!.ptr)
    }
    setTempDir(tempDir: string): void {
        CONTEXTNativeModule._Context_setTempDir(this.peer!.ptr, tempDir)
    }
    getFilesDir(): string {
        return CONTEXTNativeModule._Context_getFilesDir(this.peer!.ptr)
    }
    setFilesDir(filesDir: string): void {
        CONTEXTNativeModule._Context_setFilesDir(this.peer!.ptr, filesDir)
    }
    getDatabaseDir(): string {
        return CONTEXTNativeModule._Context_getDatabaseDir(this.peer!.ptr)
    }
    setDatabaseDir(databaseDir: string): void {
        CONTEXTNativeModule._Context_setDatabaseDir(this.peer!.ptr, databaseDir)
    }
    getPreferencesDir(): string {
        return CONTEXTNativeModule._Context_getPreferencesDir(this.peer!.ptr)
    }
    setPreferencesDir(preferencesDir: string): void {
        CONTEXTNativeModule._Context_setPreferencesDir(this.peer!.ptr, preferencesDir)
    }
    getBundleCodeDir(): string {
        return CONTEXTNativeModule._Context_getBundleCodeDir(this.peer!.ptr)
    }
    setBundleCodeDir(bundleCodeDir: string): void {
        CONTEXTNativeModule._Context_setBundleCodeDir(this.peer!.ptr, bundleCodeDir)
    }
    getDistributedFilesDir(): string {
        return CONTEXTNativeModule._Context_getDistributedFilesDir(this.peer!.ptr)
    }
    setDistributedFilesDir(distributedFilesDir: string): void {
        CONTEXTNativeModule._Context_setDistributedFilesDir(this.peer!.ptr, distributedFilesDir)
    }
    getResourceDir(): string {
        return CONTEXTNativeModule._Context_getResourceDir(this.peer!.ptr)
    }
    setResourceDir(resourceDir: string): void {
        CONTEXTNativeModule._Context_setResourceDir(this.peer!.ptr, resourceDir)
    }
    getCloudFileDir(): string {
        return CONTEXTNativeModule._Context_getCloudFileDir(this.peer!.ptr)
    }
    setCloudFileDir(cloudFileDir: string): void {
        CONTEXTNativeModule._Context_setCloudFileDir(this.peer!.ptr, cloudFileDir)
    }
    getEventHub(): EventHub {
        return CONTEXTNativeModule._Context_getEventHub(this.peer!.ptr)
    }
    setEventHub(eventHub: EventHub): void {
        CONTEXTNativeModule._Context_setEventHub(this.peer!.ptr, eventHub)
    }
    getArea(): contextConstant.AreaMode {
        return CONTEXTNativeModule._Context_getArea(this.peer!.ptr)
    }
    setArea(area: contextConstant.AreaMode): void {
        CONTEXTNativeModule._Context_setArea(this.peer!.ptr, area)
    }
    getProcessName(): string {
        return CONTEXTNativeModule._Context_getProcessName(this.peer!.ptr)
    }
    setProcessName(processName: string): void {
        CONTEXTNativeModule._Context_setProcessName(this.peer!.ptr, processName)
    }
     constructor() {
        super()
        this.peer = new Finalizable(CONTEXTNativeModule._Context_ctor(), Context.getFinalizer())
    }
    static getFinalizer(): KPointer {
        return CONTEXTNativeModule._Context_getFinalizer()
    }
    getPeer(): Finalizable | undefined {
        return this.peer
    }
    createBundleContext(bundleName: string): Context {
        const bundleName_casted = bundleName as (string)
        return this.createBundleContext_serialize(bundleName_casted)
    }
    createModuleContext(bundleName: string, moduleName?: string): Context {
        const bundleName_type = runtimeType(bundleName)
        const moduleName_type = runtimeType(moduleName)
        if ((((RuntimeType.UNDEFINED == moduleName_type)))) {
            const moduleName_casted = bundleName as (string)
            return this.createModuleContext0_serialize(moduleName_casted)
        }
        if ((((RuntimeType.STRING == moduleName_type)))) {
            const bundleName_casted = bundleName as (string)
            const moduleName_casted = moduleName as (string)
            return this.createModuleContext1_serialize(bundleName_casted, moduleName_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    createSystemHspModuleResourceManager(bundleName: string, moduleName: string): resmgr.ResourceManager {
        const bundleName_casted = bundleName as (string)
        const moduleName_casted = moduleName as (string)
        return this.createSystemHspModuleResourceManager_serialize(bundleName_casted, moduleName_casted)
    }
    getApplicationContext(): ApplicationContext {
        return this.getApplicationContext_serialize()
    }
    getGroupDir(dataGroupID: string, callback_?: ((result: string) => void)): Promise<string> | void {
        const dataGroupID_type = runtimeType(dataGroupID)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const dataGroupID_casted = dataGroupID as (string)
            return this.getGroupDir1_serialize(dataGroupID_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const dataGroupID_casted = dataGroupID as (string)
            const callback__casted = callback_ as (((result: string) => void))
            return this.getGroupDir0_serialize(dataGroupID_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    createModuleResourceManager(bundleName: string, moduleName: string): resmgr.ResourceManager {
        const bundleName_casted = bundleName as (string)
        const moduleName_casted = moduleName as (string)
        return this.createModuleResourceManager_serialize(bundleName_casted, moduleName_casted)
    }
    createAreaModeContext(areaMode: contextConstant.AreaMode): Context {
        const areaMode_casted = areaMode as (contextConstant.AreaMode)
        return this.createAreaModeContext_serialize(areaMode_casted)
    }
    createDisplayContext(displayId: number): Context {
        const displayId_casted = displayId as (number)
        return this.createDisplayContext_serialize(displayId_casted)
    }
    private createBundleContext_serialize(bundleName: string): Context {
        const retval = CONTEXTNativeModule._Context_createBundleContext(this.peer!.ptr, bundleName)
        const obj: Context = ContextInternal.fromPtr(retval)
        return obj
    }
    private createModuleContext0_serialize(moduleName: string): Context {
        const retval = CONTEXTNativeModule._Context_createModuleContext0(this.peer!.ptr, moduleName)
        const obj: Context = ContextInternal.fromPtr(retval)
        return obj
    }
    private createModuleContext1_serialize(bundleName: string, moduleName: string): Context {
        const retval = CONTEXTNativeModule._Context_createModuleContext1(this.peer!.ptr, bundleName, moduleName)
        const obj: Context = ContextInternal.fromPtr(retval)
        return obj
    }
    private createSystemHspModuleResourceManager_serialize(bundleName: string, moduleName: string): resmgr.ResourceManager {
        const retval = CONTEXTNativeModule._Context_createSystemHspModuleResourceManager(this.peer!.ptr, bundleName, moduleName)
        throw new Error("Object deserialization is not implemented.")
    }
    private getApplicationContext_serialize(): ApplicationContext {
        const retval = CONTEXTNativeModule._Context_getApplicationContext(this.peer!.ptr)
        throw new Error("Object deserialization is not implemented.")
    }
    private getGroupDir0_serialize(dataGroupID: string, callback_: ((result: string) => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._Context_getGroupDir0(this.peer!.ptr, dataGroupID, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private getGroupDir1_serialize(dataGroupID: string): Promise<string> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromise<string>()[0]
        CONTEXTNativeModule._Context_getGroupDir1(this.peer!.ptr, dataGroupID, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private createModuleResourceManager_serialize(bundleName: string, moduleName: string): resmgr.ResourceManager {
        const retval = CONTEXTNativeModule._Context_createModuleResourceManager(this.peer!.ptr, bundleName, moduleName)
        throw new Error("Object deserialization is not implemented.")
    }
    private createAreaModeContext_serialize(areaMode: contextConstant.AreaMode): Context {
        const retval = CONTEXTNativeModule._Context_createAreaModeContext(this.peer!.ptr, areaMode)
        const obj: Context = ContextInternal.fromPtr(retval)
        return obj
    }
    private createDisplayContext_serialize(displayId: number): Context {
        const retval = CONTEXTNativeModule._Context_createDisplayContext(this.peer!.ptr, displayId)
        const obj: Context = ContextInternal.fromPtr(retval)
        return obj
    }
}
export class ContextInternal {
    public static fromPtr(ptr: KPointer): Context {
        const obj: Context = new Context()
        obj.peer = new Finalizable(ptr, Context.getFinalizer())
        return obj
    }
}
export class UIAbilityContext extends Context implements UIAbilityContextInterface {
    peer: Finalizable
    getAbilityInfo(): AbilityInfo {
        return CONTEXTNativeModule._UIAbilityContext_getAbilityInfo(this.peer!.ptr)
    }
    setAbilityInfo(abilityInfo: AbilityInfo): void {
        CONTEXTNativeModule._UIAbilityContext_setAbilityInfo(this.peer!.ptr, abilityInfo)
    }
    getCurrentHapModuleInfo(): HapModuleInfo {
        return CONTEXTNativeModule._UIAbilityContext_getCurrentHapModuleInfo(this.peer!.ptr)
    }
    setCurrentHapModuleInfo(currentHapModuleInfo: HapModuleInfo): void {
        CONTEXTNativeModule._UIAbilityContext_setCurrentHapModuleInfo(this.peer!.ptr, currentHapModuleInfo)
    }
    getConfig(): Configuration {
        return CONTEXTNativeModule._UIAbilityContext_getConfig(this.peer!.ptr)
    }
    setConfig(config: Configuration): void {
        CONTEXTNativeModule._UIAbilityContext_setConfig(this.peer!.ptr, config)
    }
    getWindowStage(): window.WindowStage {
        return CONTEXTNativeModule._UIAbilityContext_getWindowStage(this.peer!.ptr)
    }
    setWindowStage(windowStage: window.WindowStage): void {
        CONTEXTNativeModule._UIAbilityContext_setWindowStage(this.peer!.ptr, windowStage)
    }
     constructor() {
        super()
        this.peer = new Finalizable(CONTEXTNativeModule._UIAbilityContext_ctor(), UIAbilityContext.getFinalizer())
    }
    static getFinalizer(): KPointer {
        return CONTEXTNativeModule._UIAbilityContext_getFinalizer()
    }
    getPeer(): Finalizable | undefined {
        return this.peer
    }
    startAbility(want: Want, options: (() => void) | StartOptions, startAbilityCallback?: (() => void)): void | Promise<void> {
        const want_type = runtimeType(want)
        const options_type = runtimeType(options)
        const startAbilityCallback_type = runtimeType(startAbilityCallback)
        if ((((RuntimeType.FUNCTION == options_type))) && (((RuntimeType.UNDEFINED == startAbilityCallback_type)))) {
            const want_casted = want as (Want)
            const startAbilityCallback_casted = options as ((() => void))
            return this.startAbility0_serialize(want_casted, startAbilityCallback_casted)
        }
        if ((((RuntimeType.OBJECT) == (options_type)) && (options instanceof StartOptions)) && (((RuntimeType.FUNCTION == startAbilityCallback_type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            const startAbilityCallback_casted = startAbilityCallback as ((() => void))
            return this.startAbility1_serialize(want_casted, options_casted, startAbilityCallback_casted)
        }
        if ((((RuntimeType.OBJECT == options_type)) || ((RuntimeType.UNDEFINED == options_type))) && (((RuntimeType.UNDEFINED == startAbilityCallback_type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            return this.startAbility2_serialize(want_casted, options_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    openLink(link: string, options: OpenLinkOptions, callback_: ((result: AbilityResult) => void)): Promise<void> {
        const link_casted = link as (string)
        const options_casted = options as (OpenLinkOptions)
        const callback__casted = callback_ as (((result: AbilityResult) => void))
        return this.openLink_serialize(link_casted, options_casted, callback__casted)
    }
    startAbilityAsCaller(want: Want, options: (() => void) | StartOptions, callback_?: (() => void)): void | Promise<void> {
        const want_type = runtimeType(want)
        const options_type = runtimeType(options)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.FUNCTION == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const callback__casted = options as ((() => void))
            return this.startAbilityAsCaller0_serialize(want_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT) == (options_type)) && (options instanceof StartOptions)) && (((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            const callback__casted = callback_ as ((() => void))
            return this.startAbilityAsCaller1_serialize(want_casted, options_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT == options_type)) || ((RuntimeType.UNDEFINED == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            return this.startAbilityAsCaller2_serialize(want_casted, options_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    startAbilityByCall(want: Want): Promise<Caller> {
        const want_casted = want as (Want)
        return this.startAbilityByCall_serialize(want_casted)
    }
    startAbilityByCallWithAccount(want: Want, accountId: number): Promise<Caller> {
        const want_casted = want as (Want)
        const accountId_casted = accountId as (number)
        return this.startAbilityByCallWithAccount_serialize(want_casted, accountId_casted)
    }
    startAbilityWithAccount(want: Want, accountId: number, options: (() => void) | StartOptions, callback_?: (() => void)): void | Promise<void> {
        const want_type = runtimeType(want)
        const accountId_type = runtimeType(accountId)
        const options_type = runtimeType(options)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.FUNCTION == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const callback__casted = options as ((() => void))
            return this.startAbilityWithAccount0_serialize(want_casted, accountId_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT) == (options_type)) && (options instanceof StartOptions)) && (((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const options_casted = options as (StartOptions)
            const callback__casted = callback_ as ((() => void))
            return this.startAbilityWithAccount1_serialize(want_casted, accountId_casted, options_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT == options_type)) || ((RuntimeType.UNDEFINED == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const options_casted = options as (StartOptions)
            return this.startAbilityWithAccount2_serialize(want_casted, accountId_casted, options_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    startAbilityForResult(want: Want, options: ((result: AbilityResult) => void) | StartOptions, callback_?: ((result: AbilityResult) => void)): void | Promise<AbilityResult> {
        const want_type = runtimeType(want)
        const options_type = runtimeType(options)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.FUNCTION == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const callback__casted = options as (((result: AbilityResult) => void))
            return this.startAbilityForResult0_serialize(want_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT) == (options_type)) && (options instanceof StartOptions)) && (((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            const callback__casted = callback_ as (((result: AbilityResult) => void))
            return this.startAbilityForResult1_serialize(want_casted, options_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT == options_type)) || ((RuntimeType.UNDEFINED == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            return this.startAbilityForResult2_serialize(want_casted, options_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    startAbilityForResultWithAccount(want: Want, accountId: number, options: ((result: AbilityResult) => void) | StartOptions, callback_?: (() => void)): void | Promise<AbilityResult> {
        const want_type = runtimeType(want)
        const accountId_type = runtimeType(accountId)
        const options_type = runtimeType(options)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.FUNCTION == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const callback__casted = options as (((result: AbilityResult) => void))
            return this.startAbilityForResultWithAccount0_serialize(want_casted, accountId_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT) == (options_type)) && (options instanceof StartOptions)) && (((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const options_casted = options as (StartOptions)
            const callback__casted = callback_ as ((() => void))
            return this.startAbilityForResultWithAccount1_serialize(want_casted, accountId_casted, options_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT == options_type)) || ((RuntimeType.UNDEFINED == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const options_casted = options as (StartOptions)
            return this.startAbilityForResultWithAccount2_serialize(want_casted, accountId_casted, options_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    startServiceExtensionAbility(want: Want, callback_?: (() => void)): Promise<void> | void {
        const want_type = runtimeType(want)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            return this.startServiceExtensionAbility1_serialize(want_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const callback__casted = callback_ as ((() => void))
            return this.startServiceExtensionAbility0_serialize(want_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    startServiceExtensionAbilityWithAccount(want: Want, accountId: number, callback_?: (() => void)): Promise<void> | void {
        const want_type = runtimeType(want)
        const accountId_type = runtimeType(accountId)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            return this.startServiceExtensionAbilityWithAccount1_serialize(want_casted, accountId_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const callback__casted = callback_ as ((() => void))
            return this.startServiceExtensionAbilityWithAccount0_serialize(want_casted, accountId_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    stopServiceExtensionAbility(want: Want, callback_?: (() => void)): Promise<void> | void {
        const want_type = runtimeType(want)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            return this.stopServiceExtensionAbility1_serialize(want_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const callback__casted = callback_ as ((() => void))
            return this.stopServiceExtensionAbility0_serialize(want_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    stopServiceExtensionAbilityWithAccount(want: Want, accountId: number, callback_?: (() => void)): Promise<void> | void {
        const want_type = runtimeType(want)
        const accountId_type = runtimeType(accountId)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            return this.stopServiceExtensionAbilityWithAccount1_serialize(want_casted, accountId_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const accountId_casted = accountId as (number)
            const callback__casted = callback_ as ((() => void))
            return this.stopServiceExtensionAbilityWithAccount0_serialize(want_casted, accountId_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    terminateSelf(callback_?: (() => void)): Promise<void> | void {
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            return this.terminateSelf1_serialize()
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const callback__casted = callback_ as ((() => void))
            return this.terminateSelf0_serialize(callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    terminateSelfWithResult(parameter: AbilityResult, callback_?: (() => void)): Promise<void> | void {
        const parameter_type = runtimeType(parameter)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const parameter_casted = parameter as (AbilityResult)
            return this.terminateSelfWithResult1_serialize(parameter_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const parameter_casted = parameter as (AbilityResult)
            const callback__casted = callback_ as ((() => void))
            return this.terminateSelfWithResult0_serialize(parameter_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    backToCallerAbilityWithResult(abilityResult: AbilityResult, requestCode: string): Promise<void> {
        const abilityResult_casted = abilityResult as (AbilityResult)
        const requestCode_casted = requestCode as (string)
        return this.backToCallerAbilityWithResult_serialize(abilityResult_casted, requestCode_casted)
    }
    connectServiceExtensionAbility(want: Want, options: ConnectOptions): number {
        const want_casted = want as (Want)
        const options_casted = options as (ConnectOptions)
        return this.connectServiceExtensionAbility_serialize(want_casted, options_casted)
    }
    connectServiceExtensionAbilityWithAccount(want: Want, accountId: number, options: ConnectOptions): number {
        const want_casted = want as (Want)
        const accountId_casted = accountId as (number)
        const options_casted = options as (ConnectOptions)
        return this.connectServiceExtensionAbilityWithAccount_serialize(want_casted, accountId_casted, options_casted)
    }
    disconnectServiceExtensionAbility(connection: number, callback_?: (() => void)): Promise<void> | void {
        const connection_type = runtimeType(connection)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const connection_casted = connection as (number)
            return this.disconnectServiceExtensionAbility1_serialize(connection_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const connection_casted = connection as (number)
            const callback__casted = callback_ as ((() => void))
            return this.disconnectServiceExtensionAbility0_serialize(connection_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    setMissionLabel(label: string, callback_?: (() => void)): Promise<void> | void {
        const label_type = runtimeType(label)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const label_casted = label as (string)
            return this.setMissionLabel1_serialize(label_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const label_casted = label as (string)
            const callback__casted = callback_ as ((() => void))
            return this.setMissionLabel0_serialize(label_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    setMissionIcon(icon: image.PixelMap, callback_?: (() => void)): Promise<void> | void {
        const icon_type = runtimeType(icon)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const icon_casted = icon as (image.PixelMap)
            return this.setMissionIcon1_serialize(icon_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const icon_casted = icon as (image.PixelMap)
            const callback__casted = callback_ as ((() => void))
            return this.setMissionIcon0_serialize(icon_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    setMissionContinueState(state: AbilityConstant.ContinueState, callback_?: (() => void)): Promise<void> | void {
        const state_type = runtimeType(state)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const state_casted = state as (AbilityConstant.ContinueState)
            return this.setMissionContinueState1_serialize(state_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const state_casted = state as (AbilityConstant.ContinueState)
            const callback__casted = callback_ as ((() => void))
            return this.setMissionContinueState0_serialize(state_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    restoreWindowStage(localStorage: LocalStorage): void {
        const localStorage_casted = localStorage as (LocalStorage)
        this?.restoreWindowStage_serialize(localStorage_casted)
        return
    }
    isTerminating(): boolean {
        return this.isTerminating_serialize()
    }
    startRecentAbility(want: Want, options: (() => void) | StartOptions, callback_?: (() => void)): void | Promise<void> {
        const want_type = runtimeType(want)
        const options_type = runtimeType(options)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.FUNCTION == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const callback__casted = options as ((() => void))
            return this.startRecentAbility0_serialize(want_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT) == (options_type)) && (options instanceof StartOptions)) && (((RuntimeType.FUNCTION == callback__type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            const callback__casted = callback_ as ((() => void))
            return this.startRecentAbility1_serialize(want_casted, options_casted, callback__casted)
        }
        if ((((RuntimeType.OBJECT == options_type)) || ((RuntimeType.UNDEFINED == options_type))) && (((RuntimeType.UNDEFINED == callback__type)))) {
            const want_casted = want as (Want)
            const options_casted = options as (StartOptions)
            return this.startRecentAbility2_serialize(want_casted, options_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    requestDialogService(want: Want, result?: ((result: dialogRequest.RequestResult) => void)): Promise<dialogRequest.RequestResult> | void {
        const want_type = runtimeType(want)
        const result_type = runtimeType(result)
        if ((((RuntimeType.UNDEFINED == result_type)))) {
            const want_casted = want as (Want)
            return this.requestDialogService1_serialize(want_casted)
        }
        if ((((RuntimeType.FUNCTION == result_type)))) {
            const want_casted = want as (Want)
            const result_casted = result as (((result: dialogRequest.RequestResult) => void))
            return this.requestDialogService0_serialize(want_casted, result_casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    reportDrawnCompleted(callback_: (() => void)): void {
        const callback__casted = callback_ as ((() => void))
        this?.reportDrawnCompleted_serialize(callback__casted)
        return
    }
    startAbilityByType(type: string, wantParam: Map<string, Object>, abilityStartCallback: AbilityStartCallback, callback_?: (() => void)): Promise<void> | void {
        const type_type = runtimeType(type)
        const wantParam_type = runtimeType(wantParam)
        const abilityStartCallback_type = runtimeType(abilityStartCallback)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const type_casted = type as (string)
            const wantParam_casted = wantParam as (Map<string, Object>)
            const abilityStartCallback_casted = abilityStartCallback as (AbilityStartCallback)
            return this.startAbilityByType1_serialize(type_casted, wantParam_casted, abilityStartCallback_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const type_casted = type as (string)
            const wantParam_casted = wantParam as (Map<string, Object>)
            const abilityStartCallback_casted = abilityStartCallback as (AbilityStartCallback)
            const callback__casted = callback_ as ((() => void))
            return this.startAbilityByType0_serialize(type_casted, wantParam_casted, abilityStartCallback_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    requestModalUIExtension(pickerWant: Want, callback_?: (() => void)): Promise<void> | void {
        const pickerWant_type = runtimeType(pickerWant)
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            const pickerWant_casted = pickerWant as (Want)
            return this.requestModalUIExtension1_serialize(pickerWant_casted)
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const pickerWant_casted = pickerWant as (Want)
            const callback__casted = callback_ as ((() => void))
            return this.requestModalUIExtension0_serialize(pickerWant_casted, callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    openAtomicService(appId: string, options: AtomicServiceOptions): Promise<AbilityResult> {
        const appId_casted = appId as (string)
        const options_casted = options as (AtomicServiceOptions)
        return this.openAtomicService_serialize(appId_casted, options_casted)
    }
    moveAbilityToBackground(): Promise<void> {
        return this.moveAbilityToBackground_serialize()
    }
    showAbility(): Promise<void> {
        return this.showAbility_serialize()
    }
    hideAbility(): Promise<void> {
        return this.hideAbility_serialize()
    }
    setRestoreEnabled(enabled: boolean): void {
        const enabled_casted = enabled as (boolean)
        this?.setRestoreEnabled_serialize(enabled_casted)
        return
    }
    startUIServiceExtensionAbility(want: Want): Promise<void> {
        const want_casted = want as (Want)
        return this.startUIServiceExtensionAbility_serialize(want_casted)
    }
    connectUIServiceExtensionAbility(want: Want, callback_: UIServiceExtensionConnectCallback): Promise<UIServiceProxy> {
        const want_casted = want as (Want)
        const callback__casted = callback_ as (UIServiceExtensionConnectCallback)
        return this.connectUIServiceExtensionAbility_serialize(want_casted, callback__casted)
    }
    disconnectUIServiceExtensionAbility(proxy: UIServiceProxy): Promise<void> {
        const proxy_casted = proxy as (UIServiceProxy)
        return this.disconnectUIServiceExtensionAbility_serialize(proxy_casted)
    }
    private startAbility0_serialize(want: Want, startAbilityCallback: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(startAbilityCallback)
        CONTEXTNativeModule._UIAbilityContext_startAbility0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbility1_serialize(want: Want, options: StartOptions, startAbilityCallback: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeStartOptions(options)
        thisSerializer.holdAndWriteCallback(startAbilityCallback)
        CONTEXTNativeModule._UIAbilityContext_startAbility1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbility2_serialize(want: Want, options: StartOptions): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeStartOptions(options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbility2(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private openLink_serialize(link: string, options: OpenLinkOptions, callback_: ((result: AbilityResult) => void)): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeCustomObject("OpenLinkOptions", options_value)
        }
        let callback__type: int32 = RuntimeType.UNDEFINED
        callback__type = runtimeType(callback_)
        thisSerializer.writeInt8(callback__type)
        if ((RuntimeType.UNDEFINED) != (callback__type)) {
            const callback__value = callback_!
            thisSerializer.holdAndWriteCallback(callback__value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_openLink(this.peer!.ptr, link, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private startAbilityAsCaller0_serialize(want: Want, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityAsCaller0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbilityAsCaller1_serialize(want: Want, options: StartOptions, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeStartOptions(options)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityAsCaller1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbilityAsCaller2_serialize(want: Want, options: StartOptions): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeStartOptions(options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityAsCaller2(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private startAbilityByCall_serialize(want: Want): Promise<Caller> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromise<Caller>()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityByCall(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private startAbilityByCallWithAccount_serialize(want: Want, accountId: number): Promise<Caller> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromise<Caller>()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityByCallWithAccount(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
        return retval
    }
    private startAbilityWithAccount0_serialize(want: Want, accountId: number, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityWithAccount0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
    }
    private startAbilityWithAccount1_serialize(want: Want, accountId: number, options: StartOptions, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeStartOptions(options)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityWithAccount1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
    }
    private startAbilityWithAccount2_serialize(want: Want, accountId: number, options: StartOptions): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeStartOptions(options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityWithAccount2(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
        return retval
    }
    private startAbilityForResult0_serialize(want: Want, callback_: ((result: AbilityResult) => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityForResult0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbilityForResult1_serialize(want: Want, options: StartOptions, callback_: ((result: AbilityResult) => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeStartOptions(options)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityForResult1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbilityForResult2_serialize(want: Want, options: StartOptions): Promise<AbilityResult> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeStartOptions(options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromise<AbilityResult>()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityForResult2(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private startAbilityForResultWithAccount0_serialize(want: Want, accountId: number, callback_: ((result: AbilityResult) => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityForResultWithAccount0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
    }
    private startAbilityForResultWithAccount1_serialize(want: Want, accountId: number, options: StartOptions, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeStartOptions(options)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityForResultWithAccount1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
    }
    private startAbilityForResultWithAccount2_serialize(want: Want, accountId: number, options: StartOptions): Promise<AbilityResult> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeStartOptions(options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromise<AbilityResult>()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityForResultWithAccount2(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
        return retval
    }
    private startServiceExtensionAbility0_serialize(want: Want, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startServiceExtensionAbility0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startServiceExtensionAbility1_serialize(want: Want): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startServiceExtensionAbility1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private startServiceExtensionAbilityWithAccount0_serialize(want: Want, accountId: number, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startServiceExtensionAbilityWithAccount0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
    }
    private startServiceExtensionAbilityWithAccount1_serialize(want: Want, accountId: number): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startServiceExtensionAbilityWithAccount1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
        return retval
    }
    private stopServiceExtensionAbility0_serialize(want: Want, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_stopServiceExtensionAbility0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private stopServiceExtensionAbility1_serialize(want: Want): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_stopServiceExtensionAbility1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private stopServiceExtensionAbilityWithAccount0_serialize(want: Want, accountId: number, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_stopServiceExtensionAbilityWithAccount0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
    }
    private stopServiceExtensionAbilityWithAccount1_serialize(want: Want, accountId: number): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_stopServiceExtensionAbilityWithAccount1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
        return retval
    }
    private terminateSelf0_serialize(callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_terminateSelf0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private terminateSelf1_serialize(): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_terminateSelf1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private terminateSelfWithResult0_serialize(parameter: AbilityResult, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("AbilityResult", parameter)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_terminateSelfWithResult0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private terminateSelfWithResult1_serialize(parameter: AbilityResult): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("AbilityResult", parameter)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_terminateSelfWithResult1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private backToCallerAbilityWithResult_serialize(abilityResult: AbilityResult, requestCode: string): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("AbilityResult", abilityResult)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_backToCallerAbilityWithResult(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), requestCode)
        thisSerializer.release()
        return retval
    }
    private connectServiceExtensionAbility_serialize(want: Want, options: ConnectOptions): number {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeCustomObject("ConnectOptions", options)
        const retval = CONTEXTNativeModule._UIAbilityContext_connectServiceExtensionAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private connectServiceExtensionAbilityWithAccount_serialize(want: Want, accountId: number, options: ConnectOptions): number {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeCustomObject("ConnectOptions", options)
        const retval = CONTEXTNativeModule._UIAbilityContext_connectServiceExtensionAbilityWithAccount(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length(), accountId)
        thisSerializer.release()
        return retval
    }
    private disconnectServiceExtensionAbility0_serialize(connection: number, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_disconnectServiceExtensionAbility0(this.peer!.ptr, connection, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private disconnectServiceExtensionAbility1_serialize(connection: number): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_disconnectServiceExtensionAbility1(this.peer!.ptr, connection, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private setMissionLabel0_serialize(label: string, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_setMissionLabel0(this.peer!.ptr, label, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private setMissionLabel1_serialize(label: string): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_setMissionLabel1(this.peer!.ptr, label, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private setMissionIcon0_serialize(icon: image.PixelMap, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("image.PixelMap", icon)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_setMissionIcon0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private setMissionIcon1_serialize(icon: image.PixelMap): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("image.PixelMap", icon)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_setMissionIcon1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private setMissionContinueState0_serialize(state: AbilityConstant.ContinueState, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("AbilityConstant.ContinueState", state)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_setMissionContinueState0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private setMissionContinueState1_serialize(state: AbilityConstant.ContinueState): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("AbilityConstant.ContinueState", state)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_setMissionContinueState1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private restoreWindowStage_serialize(localStorage: LocalStorage): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("LocalStorage", localStorage)
        CONTEXTNativeModule._UIAbilityContext_restoreWindowStage(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private isTerminating_serialize(): boolean {
        const retval = CONTEXTNativeModule._UIAbilityContext_isTerminating(this.peer!.ptr)
        return retval
    }
    private startRecentAbility0_serialize(want: Want, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startRecentAbility0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startRecentAbility1_serialize(want: Want, options: StartOptions, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeStartOptions(options)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startRecentAbility1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startRecentAbility2_serialize(want: Want, options: StartOptions): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeStartOptions(options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startRecentAbility2(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private requestDialogService0_serialize(want: Want, result: ((result: dialogRequest.RequestResult) => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(result)
        CONTEXTNativeModule._UIAbilityContext_requestDialogService0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private requestDialogService1_serialize(want: Want): Promise<dialogRequest.RequestResult> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromise<dialogRequest.RequestResult>()[0]
        CONTEXTNativeModule._UIAbilityContext_requestDialogService1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private reportDrawnCompleted_serialize(callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_reportDrawnCompleted(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbilityByType0_serialize(type: string, wantParam: Map<string, Object>, abilityStartCallback: AbilityStartCallback, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeInt32(wantParam.size)
        for (const [wantParam_key, wantParam_value] of wantParam) {
            thisSerializer.writeString(wantParam_key)
            thisSerializer.writeCustomObject("Object", wantParam_value)
        }
        thisSerializer.writeCustomObject("AbilityStartCallback", abilityStartCallback)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_startAbilityByType0(this.peer!.ptr, type, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private startAbilityByType1_serialize(type: string, wantParam: Map<string, Object>, abilityStartCallback: AbilityStartCallback): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeInt32(wantParam.size)
        for (const [wantParam_key, wantParam_value] of wantParam) {
            thisSerializer.writeString(wantParam_key)
            thisSerializer.writeCustomObject("Object", wantParam_value)
        }
        thisSerializer.writeCustomObject("AbilityStartCallback", abilityStartCallback)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startAbilityByType1(this.peer!.ptr, type, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private requestModalUIExtension0_serialize(pickerWant: Want, callback_: (() => void)): void {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(pickerWant)
        thisSerializer.holdAndWriteCallback(callback_)
        CONTEXTNativeModule._UIAbilityContext_requestModalUIExtension0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private requestModalUIExtension1_serialize(pickerWant: Want): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(pickerWant)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_requestModalUIExtension1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private openAtomicService_serialize(appId: string, options: AtomicServiceOptions): Promise<AbilityResult> {
        const thisSerializer: Serializer = Serializer.hold()
        let options_type: int32 = RuntimeType.UNDEFINED
        options_type = runtimeType(options)
        thisSerializer.writeInt8(options_type)
        if ((RuntimeType.UNDEFINED) != (options_type)) {
            const options_value = options!
            thisSerializer.writeCustomObject("AtomicServiceOptions", options_value)
        }
        const retval = thisSerializer.holdAndWriteCallbackForPromise<AbilityResult>()[0]
        CONTEXTNativeModule._UIAbilityContext_openAtomicService(this.peer!.ptr, appId, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private moveAbilityToBackground_serialize(): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_moveAbilityToBackground(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private showAbility_serialize(): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_showAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private hideAbility_serialize(): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_hideAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private setRestoreEnabled_serialize(enabled: boolean): void {
        CONTEXTNativeModule._UIAbilityContext_setRestoreEnabled(this.peer!.ptr, +enabled)
    }
    private startUIServiceExtensionAbility_serialize(want: Want): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_startUIServiceExtensionAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private connectUIServiceExtensionAbility_serialize(want: Want, callback_: UIServiceExtensionConnectCallback): Promise<UIServiceProxy> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.writeCustomObject("UIServiceExtensionConnectCallback", callback_)
        const retval = thisSerializer.holdAndWriteCallbackForPromise<UIServiceProxy>()[0]
        CONTEXTNativeModule._UIAbilityContext_connectUIServiceExtensionAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
    private disconnectUIServiceExtensionAbility_serialize(proxy: UIServiceProxy): Promise<void> {
        const thisSerializer: Serializer = Serializer.hold()
        thisSerializer.writeCustomObject("UIServiceProxy", proxy)
        const retval = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        CONTEXTNativeModule._UIAbilityContext_disconnectUIServiceExtensionAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
}
export class UIAbilityContextInternal {
    public static fromPtr(ptr: KPointer): UIAbilityContext {
        const obj: UIAbilityContext = new UIAbilityContext()
        obj.peer = new Finalizable(ptr, UIAbilityContext.getFinalizer())
        return obj
    }
}
