/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
import { AsyncCallback } from './@ohos.base';
/**
 * Provides the system event logging function for applications to log the fault, statistical, security,
 * and user behavior events reported during running. Based on event information,
 * you will be able to analyze the running status of applications.
 *
 * @namespace hiSysEvent
 * @syscap SystemCapability.HiviewDFX.HiSysEvent
 * @systemapi hide for inner use
 * @since 20
 */
declare namespace hiSysEvent {
    /**
     * Enumerate system event types.
     *
     * @enum {int}
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    enum EventType {
        /**
         * Fault event
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        FAULT = 1,
        /**
         * Statistic event
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        STATISTIC = 2,
        /**
         * Security event
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        SECURITY = 3,
        /**
         * System behavior event
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        BEHAVIOR = 4
    }
    /**
     * Definition of written system event information.
     *
     * @interface SysEventInfo
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    interface SysEventInfo {
        /**
         * The domain of the event.
         *
         * @type { string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        domain: string;
        /**
         * The name of the event.
         *
         * @type { string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        name: string;
        /**
         * The type of the event.
         *
         * @type { EventType }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        eventType: EventType;
        /**
         * The params of the event.
         *
         * @type { ?Record<string, boolean | int | double | string | bigint | boolean[] | int[] | double[] | string[] | bigint[]> }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        params?: Record<string, boolean | int | double | string | bigint | boolean[] | int[] | double[] | string[] | bigint[]>;
    }
    /**
     * Write system event.
     *
     * @param {SysEventInfo} info - system event information to be written.
     * @returns {Promise<void>} - Return Promise
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200001 - Invalid event domain.
     * @throws {BusinessError} 11200002 - Invalid event name.
     * @throws {BusinessError} 11200003 - Abnormal environment.
     * @throws {BusinessError} 11200004 - The event length exceeds the limit.
     * @throws {BusinessError} 11200051 - Invalid event parameter.
     * @throws {BusinessError} 11200052 - The size of the event parameter of the string type exceeds the limit.
     * @throws {BusinessError} 11200053 - The number of event parameters exceeds the limit.
     * @throws {BusinessError} 11200054 - The number of event parameters of the array type exceeds the limit.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function write(info: SysEventInfo): Promise<void>;
    /**
     * Write system event.
     *
     * @param {SysEventInfo} info - system event information to be written.
     * @param {AsyncCallback<void>} callback - callback function.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200001 - Invalid event domain.
     * @throws {BusinessError} 11200002 - Invalid event name.
     * @throws {BusinessError} 11200003 - Abnormal environment.
     * @throws {BusinessError} 11200004 - The event length exceeds the limit.
     * @throws {BusinessError} 11200051 - Invalid event parameter.
     * @throws {BusinessError} 11200052 - The size of the event parameter of the string type exceeds the limit.
     * @throws {BusinessError} 11200053 - The number of event parameters exceeds the limit.
     * @throws {BusinessError} 11200054 - The number of event parameters of the array type exceeds the limit.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function write(info: SysEventInfo, callback: AsyncCallback<void>): void;
    /**
     * Enumerate search system event rule type.
     *
     * @enum {int}
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    enum RuleType {
        /**
         * Whole word match
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        WHOLE_WORD = 1,
        /**
         * Prefix match
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        PREFIX = 2,
        /**
         * Regular match
         *
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        REGULAR = 3
    }
    /**
     * Definition listener rule for system event information.
     *
     * @interface WatchRule
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    interface WatchRule {
        /**
         * The domain of the event.
         *
         * @type { string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        domain: string;
        /**
         * The name of the event.
         *
         * @type { string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        name: string;
        
        /**
         * The tag of the event.
         *
         * @type { ?string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        tag?: string;
        /**
         * The rule of match system event
         *
         * @type { RuleType }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        ruleType: RuleType;
    }
    /**
     * Definition watcher for system event information.
     *
     * @interface Watcher
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    interface Watcher {
        /**
         * Rule of filter system event
         *
         * @type { WatchRule[] }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        rules: WatchRule[];
        /**
        * Receive system event.
        *
        * @type { function }
        * @syscap SystemCapability.HiviewDFX.HiSysEvent
        * @systemapi hide for inner use
        * @since 20
        */
        onEvent: (info: SysEventInfo) => void;
        /**
         * Hisysevent service shutdown.
         *
         * @type { function }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        onServiceDied: () => void;
    }
    /**
     * Definition arguments for query system event information.
     *
     * @interface QueryArg
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    interface QueryArg {
        /**
         * Begin time
         *
         * @type { long }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        beginTime: long;
        /**
         * End time
         *
         * @type { long }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        endTime: long;
        /**
         * Max number of receive system event
         *
         * @type { long }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        maxEvents: long;
        /**
         * Begin sequence
         *
         * @type { ?long }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        fromSeq?: long;
        /**
         * End sequence
         *
         * @type { ?long }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        toSeq?: long;
    }
    /**
     * Definition event for query system event information
     *
     * @interface QueryRule
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    interface QueryRule {
        /**
         * The domain of the event
         *
         * @type { string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        domain: string;
        /**
         * List of event name
         *
         * @type { string[] }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        names: string[];
        /**
         * Extra parameter condition of event
         *
         * @type { ?string }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        condition?: string;
    }
    /**
     * Definition query result handler
     *
     * @interface Querier
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    interface Querier {
        /**
         * Handle query result, the query result will be send in several times.
         *
         * @type { function }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        onQuery: (infos: SysEventInfo[]) => void;
        /**
         * Notify querier execute query has finished.
         *
         * @type { function }
         * @syscap SystemCapability.HiviewDFX.HiSysEvent
         * @systemapi hide for inner use
         * @since 20
         */
        onComplete: (reason: int, total: int) => void;
    }
    /**
     * Add watcher to watch system event
     *
     * @permission ohos.permission.READ_DFX_SYSEVENT
     * @param {Watcher} watcher watch system event
     * @throws {BusinessError} 201 - Permission denied. An attempt was made to read system event forbidden by permission: ohos.permission.READ_DFX_SYSEVENT.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200101 - The number of watchers exceeds the limit.
     * @throws {BusinessError} 11200102 - The number of watch rules exceeds the limit.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function addWatcher(watcher: Watcher): void;
    /**
     * Remove watcher
     *
     * @permission ohos.permission.READ_DFX_SYSEVENT
     * @param {Watcher} watcher watch system event
     * @throws {BusinessError} 201 - Permission denied. An attempt was made to read system event forbidden by permission: ohos.permission.READ_DFX_SYSEVENT.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200201 - The watcher does not exist.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function removeWatcher(watcher: Watcher): void;
    /**
     * Query system event
     *
     * @permission ohos.permission.READ_DFX_SYSEVENT
     * @param {QueryArg} queryArg common arguments of query system event
     * @param {QueryRule[]} rules rule of query system event
     * @param {Querier} querier receive query result
     * @throws {BusinessError} 201 - Permission denied. An attempt was made to read system event forbidden by permission: ohos.permission.READ_DFX_SYSEVENT.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200301 - The number of query rules exceeds the limit.
     * @throws {BusinessError} 11200302 - Invalid query rule.
     * @throws {BusinessError} 11200303 - The number of concurrent queriers exceeds the limit.
     * @throws {BusinessError} 11200304 - The query frequency exceeds the limit.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function query(queryArg: QueryArg, rules: QueryRule[], querier: Querier): void;
    /**
     * Export system event
     *
     * @permission ohos.permission.READ_DFX_SYSEVENT
     * @param {QueryArg} queryArg common arguments of query system event
     * @param {QueryRule[]} rules rule of query system event
     * @returns {long} return hiview receive task time.
     * @throws {BusinessError} 201 - Permission denied. An attempt was made to read system event forbidden by permission: ohos.permission.READ_DFX_SYSEVENT.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200301 - The number of query rules exceeds the limit.
     * @throws {BusinessError} 11200302 - Invalid query rule.
     * @throws {BusinessError} 11200304 – The query frequency exceeds the limit.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function exportSysEvents(queryArg: QueryArg, rules: QueryRule[]): long;
    /**
     * Subscribe system event
     *
     * @permission ohos.permission.READ_DFX_SYSEVENT
     * @param {QueryRule[]} rules rule of subscribe system event
     * @returns {long} return hiview receive task time.
     * @throws {BusinessError} 201 - Permission denied. An attempt was made to read system event forbidden by permission: ohos.permission.READ_DFX_SYSEVENT.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200301 - The number of query rules exceeds the limit.
     * @throws {BusinessError} 11200302 - Invalid query rule.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function subscribe(rules: QueryRule[]): long;
    /**
     * Unsubscribe system event
     *
     * @permission ohos.permission.READ_DFX_SYSEVENT
     * @throws {BusinessError} 201 - Permission denied. An attempt was made to read system event forbidden by permission: ohos.permission.READ_DFX_SYSEVENT.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes:
     *                         1. Mandatory parameters are left unspecified.
     *                         2. Incorrect parameter types.
     *                         3. Parameter verification failed.
     * @throws {BusinessError} 11200305 – Unsubscription failed.
     * @syscap SystemCapability.HiviewDFX.HiSysEvent
     * @systemapi hide for inner use
     * @since 20
     */
    function unsubscribe(): void;
}
export default hiSysEvent;
