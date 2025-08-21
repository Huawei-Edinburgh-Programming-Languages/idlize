/*
* Copyright (C) 2022 Huawei Device Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
/**
 * @file
 * @kit PerformanceAnalysisKit
 */

/**
 * This module provides multiple methods for debugging and profiling applications. With these methods, you can obtain
 * memory, CPU, GPU, and GC data, collect process trace and profiler data, and dump VM heap snapshots. Since most APIs
 * of this module are both performance-consuming and time-consuming, and are defined based on the HiDebug module,
 * you are advised to use these APIs only during the application debugging and profiling phases. If the APIs are
 * required in other scenarios, evaluate the impact of the APIs on application performance.
 *
 * @namespace hidebug
 * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
 * @since 20
 */
declare namespace hidebug {
    /**
     * Obtains the total number of bytes occupied by the total space (the sum of uordblks and fordblks obtained from
     * mallinfo) held by a process, which is measured by the memory allocator.
     *
     * @returns { bigint } Returns the total number of bytes occupied by the total space.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getNativeHeapSize(): bigint;
    /**
     * Obtains the total number of bytes occupied by the total allocated space (uordblks obtained from mallinfo) held by
     * a process, which is measured by the memory allocator.
     * @returns { bigint } Returns the total number of bytes occupied by the total allocated space.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getNativeHeapAllocatedSize(): bigint;
    /**
     * Obtains the total number of bytes occupied by the total free space (fordblks obtained from mallinfo)
     * held by a process, which is measured by the memory allocator.
     *
     * @returns { bigint } Returns the size of the memory occupied by the free normal blocks held by the process, in bytes.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getNativeHeapFreeSize(): bigint;
    /**
     * Obtains the virtual set size used by the application process. This API is implemented by multiplying the value of
     * size (number of memory pages) in the /proc/{pid}/statm node by the page size (4 KB per page).
     *
     * @returns { bigint } Returns the virtual set size used by the application process, in KB.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getVss(): bigint;
    /**
     * Obtains the size of the physical memory actually used by the application process. This API is implemented by
     * summing up the values of **Pss** and **SwapPss** in the /proc/{pid}/smaps_rollup** node.
     *
     * @returns { bigint } Returns the size of the physical memory actually used by the application process, in KB.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getPss(): bigint;
    /**
     * Obtains the size of the shared dirty memory of a process. This API is implemented by reading the value of
     * Shared_Dirty in the /proc/{pid}/smaps_rollup node.
     *
     * @returns { bigint } Returns the size of the shared dirty memory of the process, in KB.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getSharedDirty(): bigint;
    /**
     * Obtains the size of the private dirty memory of a process. This API is implemented by reading the value of
     * Private_Dirty in the /proc/{pid}/smaps_rollup node.
     *
     * @returns { bigint } Returns the size of the private dirty memory of the process, in KB.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getPrivateDirty(): bigint;
    /**
     * Obtains the CPU usage of a process.
     *
     * @returns { double } Returns the CPU usage of the process.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getCpuUsage(): double;
    /**
     * Obtains system service information.
     * It need dump permission.
     * This API can be called only by system application.
     *
     * @permission ohos.permission.DUMP
     * @param { int } serviceid - Obtains the system service information based on the specified service ID.
     * @param { int } fd - File descriptor to which data is written by the API.
     * @param { Array<string> } args - Parameter list of the Dump API of the system service.
     * @throws {BusinessError} 401 - the parameter check failed,Possible causes:
     *                               1.the parameter type error
     *                               2.the args parameter is not string array.
     * @throws {BusinessError} 11400101 - ServiceId invalid. The system ability does not exist.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getServiceDump(serviceid: int, fd: int, args: Array<string>): void;
    /**
     * Obtains the CPU usage of the system.
     *
     * @returns { double } Returns the CPU usage of the system.
     * @throws { BusinessError } 11400104 - The status of the system CPU usage is abnormal.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getSystemCpuUsage(): double;
    /**
     * Describes the CPU usage of a thread.
     *
     * @interface ThreadCpuUsage
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    interface ThreadCpuUsage {
        /**
         * Thread id
         *
         * @type { long }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        threadId: long;
        /**
         * CPU usage of the thread.
         *
         * @type { double }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        cpuUsage: double;
    }
    /**
     * Obtains the CPU usage of application threads.
     *
     * @returns { ThreadCpuUsage[] } Returns the CPU usage of all threads of the current application process.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getAppThreadCpuUsage(): ThreadCpuUsage[];
    /**
     * Describes the system memory information, including the total memory, free memory, and available memory.
     *
     * @interface SystemMemInfo
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    interface SystemMemInfo {
        /**
         * Total memory of the system, in KB. The value of this parameter is obtained by reading the value of
         * MemTotal in the /proc/meminfo node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        totalMem: bigint;
        /**
         * Free memory of the system, in KB. The value of this parameter is obtained by reading the value of
         * MemFree in the /proc/meminfo node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        freeMem: bigint;
        /**
         * Available memory of the system, in KB. The value of this parameter is obtained by reading the value of
         * MemAvailable in the /proc/meminfo node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        availableMem: bigint;
    }
    /**
     * Obtains system memory information. This API is implemented by reading data from the /proc/meminfo node.
     *
     * @returns { SystemMemInfo } Returns the system memory information.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getSystemMemInfo(): SystemMemInfo;
    /**
     * Describes memory information of the application process.
     *
     * @interface NativeMemInfo
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    interface NativeMemInfo {
        /**
         * Size of the occupied physical memory (including the proportionally allocated memory occupied by the shared
         * library), in KB. The value of this parameter is obtained by summing up the values of Pss and SwapPss in the
         * /proc/{pid}/smaps_rollup node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        pss: bigint;
        /**
         * Size of the occupied virtual memory (including the memory occupied by the shared library), in KB. The value of
         * this parameter is obtained by multiplying the value of size (number of memory pages) in the /proc/{pid}/statm
         * node by the page size (4 KB per page).
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        vss: bigint;
        /**
         * Size of the occupied physical memory (including the memory occupied by the shared library), in KB.
         * The value of this parameter is obtained by reading the value of Rss in the /proc/{pid}/smaps_rollup node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        rss: bigint;
        /**
         * Size of the shared dirty memory, in KB. The value of this parameter is obtained by reading the value of
         * Shared_Dirty in the /proc/{pid}/smaps_rollup node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        sharedDirty: bigint;
        /**
         * Size of the private dirty memory, in KB. The value of this parameter is obtained by reading the value of
         * Private_Dirty in the /proc/{pid}/smaps_rollup node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        privateDirty: bigint;
        /**
         * Size of the shared clean memory, in KB. The value of this parameter is obtained by reading the value of
         * Shared_Clean in the /proc/{pid}/smaps_rollup node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        sharedClean: bigint;
        /**
         * Size of the private clean memory, in KB. The value of this parameter is obtained by reading the value of
         * Private_Clean in the /proc/{pid}/smaps_rollup node.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        privateClean: bigint;
    }
    /**
     * Obtains the memory information of the application process. This API is implemented by reading data from the
     * /proc/{pid}/smaps_rollup and /proc/{pid}/statm node.
     *
     * @returns { NativeMemInfo } Returns the memory information of the application process.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getAppNativeMemInfo(): NativeMemInfo;
    /**
     * Defines the memory limit of the application process.
     *
     * @interface MemoryLimit
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    interface MemoryLimit {
        /**
         * Limit on the resident set size, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        rssLimit: bigint;
        /**
         * Limit on the virtual memory size, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        vssLimit: bigint;
        /**
         * Limit on the JS VM heap size of the calling thread, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        vmHeapLimit: bigint;
        /**
         * Size limit of the JS heap memory of the process, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        vmTotalHeapSize: bigint;
    }
    /**
     * Obtains the memory limit of an application process.
     *
     * @returns { MemoryLimit } Returns the memory limit of the application process.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getAppMemoryLimit(): MemoryLimit;
    /**
     * Describes the VM memory information.
     *
     * @interface VMMemoryInfo
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    interface VMMemoryInfo {
        /**
         * Total heap size of the current VM, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        totalHeap: bigint;
        /**
         * Heap size used by the current VM, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        heapUsed: bigint;
        /**
         * Size of all array objects of the current VM, in KB.
         *
         * @type { bigint }
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        allArraySize: bigint;
    }
    /**
     * Obtains VM memory information.
     *
     * @returns { VMMemoryInfo } Returns the VM memory information.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getAppVMMemoryInfo(): VMMemoryInfo;
    /**
     * Describes types of trace collection threads, including the main thread and all threads.
     *
     * @enum { int }
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    enum TraceFlag {
        /**
         * The main thread of the application.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        MAIN_THREAD = 1,
        /**
         * All threads of the application.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        ALL_THREADS = 2
    }
    /**
     * Enumerates the tags used in trace collection.
     *
     * @namespace tags
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    namespace tags {
        /**
         * Ability Manager tag. The corresponding HiTrace command is tagName:ability.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const ABILITY_MANAGER: long;
        /**
         * ArkUI development framework. The corresponding HiTrace command is tagName:ace.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const ARKUI: long;
        /**
         * JSVM VM. The corresponding HiTrace command is tagName:ark.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const ARK: long;
        /**
         * Bluetooth. The corresponding HiTrace command is tagName:bluetooth.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const BLUETOOTH: long;
        /**
         * Common library subsystem. The corresponding HiTrace command is tagName:commonlibrary.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const COMMON_LIBRARY: long;
        /**
         * Distributed hardware device management. The corresponding HiTrace command is tagName:devicemanager.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_HARDWARE_DEVICE_MANAGER: long;
        /**
         * Distributed audio. The corresponding HiTrace command is tagName:daudio.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_AUDIO: long;
        /**
         * Distributed camera. The corresponding HiTrace command is tagName:dcamera.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_CAMERA: long;
        /**
         * Distributed data management. The corresponding HiTrace command is tagName:distributeddatamgr.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_DATA: long;
        /**
         * Distributed hardware framework. The corresponding HiTrace command is tagName:dhfwk.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_HARDWARE_FRAMEWORK: long;
        /**
         * Distributed input. The corresponding HiTrace command is tagName:dinput.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_INPUT: long;
        /**
         * Distributed screen. The corresponding HiTrace command is tagName:dscreen.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_SCREEN: long;
        /**
         * Distributed scheduler. The corresponding HiTrace command is tagName:dsched.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const DISTRIBUTED_SCHEDULER: long;
        /**
         * FFRT task. The corresponding HiTrace command is tagName:ffrt.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const FFRT: long;
        /**
         * File management system. The corresponding HiTrace command is tagName:filemanagement.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const FILE_MANAGEMENT: long;
        /**
         * Global resource management. The corresponding HiTrace command is tagName:gresource.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const GLOBAL_RESOURCE_MANAGER: long;
        /**
         * Graphics module. The corresponding HiTrace command is tagName:graphic.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const GRAPHICS: long;
        /**
         * HDF subsystem. The corresponding HiTrace command is tagName:hdf.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const HDF: long;
        /**
         * MISC module. The corresponding HiTrace command is tagName:misc.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const MISC: long;
        /**
         * Multi-modal input module. The corresponding HiTrace command is tagName:multimodalinput.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const MULTIMODAL_INPUT: long;
        /**
         * Network. The corresponding HiTrace command is tagName:net.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const NET: long;
        /**
         * Notification module. The corresponding HiTrace command is tagName:notification.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const NOTIFICATION: long;
        /**
         * Nweb. The corresponding HiTrace command is tagName:nweb.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const NWEB: long;
        /**
         * OHOS. The corresponding HiTrace command is tagName:ohos.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const OHOS: long;
        /**
         * Power management. The corresponding HiTrace command is tagName:power.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const POWER_MANAGER: long;
        /**
         * RPC. The corresponding HiTrace command is tagName:rpc.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const RPC: long;
        /**
         * System capability management. The corresponding HiTrace command is tagName:samgr.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const SAMGR: long;
        /**
         * Window management. The corresponding HiTrace command is tagName:window.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const WINDOW_MANAGER: long;
        /**
         * Audio module. The corresponding HiTrace command is tagName:zaudio.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const AUDIO: long;
        /**
         * Camera module. The corresponding HiTrace command is tagName:zcamera.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const CAMERA: long;
        /**
         * Image module. The corresponding HiTrace command is tagName:zimage.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const IMAGE: long;
        /**
         * Media module. The corresponding HiTrace command is tagName:zmedia.
         *
         * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
         * @since 20
         */
        const MEDIA: long;
    }
    /**
     * Starts automatic trace collection in a specified scope. This API is a supplement to the HiTrace module.
     * The performance consumption during trace collection increases with the collection scope. Therefore, before
     * using this API, you are advised to run the hitrace command to capture trace logs and select the key scope
     * of trace collection to improve the API performance.
     *
     * @param { long[] } tags - Scope for trace collection. For details, see tags.
     * @param { TraceFlag } flag - For details, see TraceFlag.
     * @param { int } limitSize - Limit on the trace file size, in bytes. The maximum size of a single file is 500 MB.
     * @returns { string } Returns the path of the trace file.
     * @throws { BusinessError } 401 - Invalid argument, Possible causes:
     *                           1.The limit parameter is too small
     *                           2.The parameter is not within the enumeration type
     *                           3.The parameter type error or parameter order error
     * @throws { BusinessError } 11400102 - Capture trace already enabled.
     * @throws { BusinessError } 11400103 - No write permission on the file.
     * @throws { BusinessError } 11400104 - Abnormal trace status.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function startAppTraceCapture(tags: long[], flag: TraceFlag, limitSize: int): string;
    /**
     * Stops application trace collection. Use startAppTraceCapture() to start collection before calling this API.
     * If this API is called before trace collection or it is repeatedly called, an exception will occur.
     *
     * @throws { BusinessError } 11400104 - The status of the trace is abnormal.
     * @throws { BusinessError } 11400105 - No capture trace running.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function stopAppTraceCapture(): void;
    /**
     * Describes the key-value pair used to store GC statistics. This type does not support multi-thread operations.
     * If this type is operated by multiple threads at the same time in an application, use a lock for it.
     *
     * @typedef { Record<string, long> } GcStats
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    type GcStats = Record<string, long>;
    /**
     * Obtains all system GC statistics.
     *
     * @returns { GcStats } Returns the system GC statistics.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getVMRuntimeStats(): GcStats;
    /**
     * Obtains the specified system GC statistics based on parameters.
     *
     * @param { string } item - statistical item.
     * @returns { long } Returns the item of the GC statistics to be obtained.
     * @throws { BusinessError } 401 - Possible causes:
     *                           1. Invalid parameter, a string parameter required.
     *                           2. Invalid parameter, unknown property.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getVMRuntimeStat(item: string): long;
    /**
     * Obtains the debugging state of an application process. If the Ark or native layer of the application process is in
     * debugging state, true is returned. Otherwise, false is returned.
     *
     * @returns { boolean } true if the application is in the debugging state.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function isDebugState(): boolean;
    /**
     * Obtains the size of the GPU memory. This API uses a promise to return the result.
     *
     * @returns { Promise<int> } Returns the size of the GPU memory, in KB.
     * @throws { BusinessError } 11400104 - Failed to get the application memory due to a remote exception.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getGraphicsMemory(): Promise<int>;
    /**
     * Obtains the size of the GPU memory synchronously.
     *
     * @returns { int } Returns the size of the GPU memory, in KB.
     * @throws { BusinessError } 11400104 - Failed to get the application memory due to a remote exception.
     * @syscap SystemCapability.HiviewDFX.HiProfiler.HiDebug
     * @since 20
     */
    function getGraphicsMemorySync(): int;
}
export default hidebug;
