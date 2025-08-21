/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
 * @kit AbilityKit
 */
import { AsyncCallback } from './@ohos.base';
import { MissionInfo as _MissionInfo } from './application/MissionInfo';
/**
 * This module provides the capability to manage abilities and obtaining system task information.
 *
 * @namespace missionManager
 * @syscap SystemCapability.Ability.AbilityRuntime.Mission
 * @systemapi
 * @since 20
 */
declare namespace missionManager {
    /**
     * Get the missionInfo with the given missionId.
     *
     * @permission ohos.permission.MANAGE_MISSIONS
     * @param { string } deviceId - Indicates the device to be queried.
     * @param { int } missionId - Indicates mission id to be queried.
     * @param { AsyncCallback<MissionInfo> } callback - The callback is used to return the MissionInfo of the given id.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Mission
     * @systemapi
     * @since 20
     */
    function getMissionInfo(deviceId: string, missionId: int, callback: AsyncCallback<MissionInfo>): void;
    /**
     * Get the missionInfo with the given missionId.
     *
     * @permission ohos.permission.MANAGE_MISSIONS
     * @param { string } deviceId - Indicates the device to be queried.
     * @param { int } missionId - Indicates mission id to be queried.
     * @returns { Promise<MissionInfo> } Returns the MissionInfo of the given id.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Mission
     * @systemapi
     * @since 20
     */
    function getMissionInfo(deviceId: string, missionId: int): Promise<MissionInfo>;
    /**
     * Clear all missions in the ability manager service.
     *
     * @permission ohos.permission.MANAGE_MISSIONS
     * @param { AsyncCallback<void> } callback - The callback of clearAllMissions.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Mission
     * @systemapi
     * @since 20
     */
    function clearAllMissions(callback: AsyncCallback<void>): void;
    /**
     * Clear all missions in the ability manager service.
     *
     * @permission ohos.permission.MANAGE_MISSIONS
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @syscap SystemCapability.Ability.AbilityRuntime.Mission
     * @systemapi
     * @since 20
     */
    function clearAllMissions(): Promise<void>;
    /**
     * Mission information corresponding to ability.
     *
     * @typedef { _MissionInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Mission
     * @systemapi
     * @since 20
     */
    export type MissionInfo = _MissionInfo;
}
export default missionManager;
