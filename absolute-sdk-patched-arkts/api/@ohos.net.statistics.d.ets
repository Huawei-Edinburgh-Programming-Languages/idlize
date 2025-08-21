/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
 * @kit NetworkKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
import type connection from './@ohos.net.connection';

/**
 * Obtains traffic statistics.
 * @namespace statistics
 * @syscap SystemCapability.Communication.NetManager.Core
 * @since 20
 */
declare namespace statistics {
    /**
     * @typedef {connection.NetBearType}
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    type NetBearType = connection.NetBearType;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through a specified NIC.
     * @param { string } nic - Network interface card.
     * @param { AsyncCallback<long> } callback - Returns the data traffic received through the specified NIC.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getIfaceRxBytes(nic: string, callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through a specified NIC.
     * @param { string } nic - Network interface card.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getIfaceRxBytes(nic: string): Promise<long>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through a specified NIC.
     * @param { string } nic - Network interface card.
     * @param { AsyncCallback<long> } callback - Returns the data traffic sent through the specified NIC.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getIfaceTxBytes(nic: string, callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through a specified NIC.
     * @param { string } nic - Network interface card.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getIfaceTxBytes(nic: string): Promise<long>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through the cellular network.
     * @param { AsyncCallback<long> } callback - Returns the data traffic received through the cellular network.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getCellularRxBytes(callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through the cellular network.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getCellularRxBytes(): Promise<long>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through the cellular network.
     * @param { AsyncCallback<long> } callback - Returns the data traffic sent through the cellular network.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getCellularTxBytes(callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through the cellular network.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @throws { BusinessError } 2103012 - Failed to obtain the NIC name.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getCellularTxBytes(): Promise<long>;
    
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through all NICs.
     * @param { AsyncCallback<long> } callback - Returns the data traffic received through all NICs.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getAllRxBytes(callback: AsyncCallback<long>): void;
    
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through all NICs.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getAllRxBytes(): Promise<long>;
    
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through all NICs.
     * @param { AsyncCallback<long> } callback - Returns the data traffic sent through all NICs.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getAllTxBytes(callback: AsyncCallback<long>): void;
    
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through all NICs.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getAllTxBytes(): Promise<long>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received by a specified application.
     * @param { int } uid - Indicates the process ID of the application.
     * @param { AsyncCallback<long> } callback - Returns the data traffic received by the specified application.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getUidRxBytes(uid: int, callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received by a specified application.
     * @param { int } uid - Indicates the process ID of the application.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getUidRxBytes(uid: int): Promise<long>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent by a specified application.
     * @param { int } uid - Indicates the process ID of the application.
     * @param { AsyncCallback<long> } callback - Returns the data traffic sent by the specified application.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getUidTxBytes(uid: int, callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent by a specified application.
     * @param { int } uid - Indicates the process ID of the application.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103005 - Failed to read the system map.
     * @throws { BusinessError } 2103011 - Failed to create a system map.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getUidTxBytes(uid: int): Promise<long>;
    /**
     * Get the traffic usage details of the network interface in the specified time period.
     * @permission ohos.permission.GET_NETWORK_STATS
     * @param { IfaceInfo } ifaceInfo - Detailed query content. See {@link IfaceInfo}.
     * @param { AsyncCallback<NetStatsInfo> } callback - Returns the {@link NetStatsInfo} object;
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103017 - Failed to read the database.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getTrafficStatsByIface(ifaceInfo: IfaceInfo, callback: AsyncCallback<NetStatsInfo>): void;
    /**
     * Get the traffic usage details of the network interface in the specified time period.
     * @permission ohos.permission.GET_NETWORK_STATS
     * @param { IfaceInfo } ifaceInfo - Detailed query content. See {@link IfaceInfo}.
     * @returns { Promise<NetStatsInfo> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103017 - Failed to read the database.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getTrafficStatsByIface(ifaceInfo: IfaceInfo): Promise<NetStatsInfo>;
    /**
     * Get the traffic usage details of the specified time period of the application.
     * @permission ohos.permission.GET_NETWORK_STATS
     * @param { UidInfo } uidInfo - Detailed query content. See {@link UidInfo}.
     * @param { AsyncCallback<NetStatsInfo> } callback - Returns the {@link NetStatsInfo} object;
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103017 - Failed to read the database.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getTrafficStatsByUid(uidInfo: UidInfo, callback: AsyncCallback<NetStatsInfo>): void;
    /**
     * Get the traffic usage details of the specified time period of the application.
     * @permission ohos.permission.GET_NETWORK_STATS
     * @param { UidInfo } uidInfo - Detailed query content. See {@link UidInfo}.
     * @returns { Promise<NetStatsInfo> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @throws { BusinessError } 2103017 - Failed to read the database.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getTrafficStatsByUid(uidInfo: UidInfo): Promise<NetStatsInfo>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through a specified sockfd.
     * @param { int } sockfd - Indicates the file descriptor of the given socket.
     * @param { AsyncCallback<long> } callback - Returns the data traffic bytes received by the specified sockfd.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getSockfdRxBytes(sockfd: int, callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) received through a specified sockfd.
     * @param { int } sockfd - Indicates the file descriptor of the given socket.
     * @returns { Promise<long> } Returns the data traffic bytes received by the specified sockfd.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value.
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getSockfdRxBytes(sockfd: int): Promise<long>;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through a specified sockfd.
     * @param { int } sockfd - Indicates the file descriptor of the given socket.
     * @param { AsyncCallback<long> } callback - Returns the data traffic bytes sent by the specified sockfd.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getSockfdTxBytes(sockfd: int, callback: AsyncCallback<long>): void;
    /**
     * Queries the data traffic (including all TCP and UDP data packets) sent through a specified sockfd.
     * @param { int } sockfd - Indicates the file descriptor of the given socket.
     * @returns { Promise<long> } Returns the data traffic bytes sent by the specified sockfd.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 2100001 - Invalid parameter value
     * @throws { BusinessError } 2100002 - Failed to connect to the service.
     * @throws { BusinessError } 2100003 - System internal error.
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    function getSockfdTxBytes(sockfd: int): Promise<long>;
    /**
     * Parameters for obtaining detailed information on network interface traffic usage.
     * @interface IfaceInfo
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface IfaceInfo {
        /**
         * Network interface for querying traffic.
         * @type {string}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        iface: string;
        /**
         * Start time for querying traffic.
         * @type {int}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        startTime: int;
        /**
         * End time for querying traffic.
         * @type {int}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        endTime: int;
    }
    /**
     * Parameters for obtaining detailed information on application traffic usage.
     * @interface UidInfo
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface UidInfo {
        /**
         * See {@link IfaceInfo}
         * @type {IfaceInfo}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ifaceInfo: IfaceInfo;
        /**
         * Uid of app for querying traffic.
         * @type {int}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        uid: int;
    }
    /**
     * Detailed information of statistics.
     * @interface NetStatsInfo
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface NetStatsInfo {
        /**
         * Bytes of received.
         * @type {long}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        rxBytes: long;
        /**
         * Bytes of send.
         * @type {long}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        txBytes: long;
        /**
         * Packets of received.
         * @type {long}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        rxPackets: long;
        /**
         * Packets of send.
         * @type {long}
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        txPackets: long;
    }
    /**
     * Used to monitor and manage the status and usage of network interfaces.
     * @interface NetStatsChangeInfo
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface NetStatsChangeInfo {
        /**
         * Network interface for querying traffic.
         * @type { string }
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        iface: string;
        /**
         * Network interface for querying traffic.
         * @type { ?int }
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        uid?: int;
    }
    /**
     * Parameters for obtaining detailed information on specified network traffic usage.
     * @interface NetworkInfo
     * @syscap SystemCapability.Communication.NetManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface NetworkInfo {
        /**
         * Network type for querying traffic.
         * @type { NetBearType }
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        type: NetBearType;
        /**
         * Start time for querying traffic.
         * @type { int }
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        startTime: int;
        /**
         * End time for querying traffic.
         * @type { int }
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        endTime: int;
        /**
         * SIM card id for querying traffic.
         * @type { ?int }
         * @syscap SystemCapability.Communication.NetManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        simId?: int;
    }
}
export default statistics;
