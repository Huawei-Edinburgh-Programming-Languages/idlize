/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 * @kit AbilityKit
 */
import { ElementName } from '../bundleManager/ElementName';
import rpc from './../@ohos.rpc';
/**
 * The callback interface was connect successfully.
 *
 * @typedef { Function }
 * @param { ElementName } elementName - The ohos.bundleManager.ElementName object of the service ability
 * @param { rpc.IRemoteObject } remote - The remote object instance
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
type OnConnectFn = (elementName: ElementName, remote: rpc.IRemoteObject) => void;
/**
 * The callback interface was disconnect successfully.
 *
 * typedef { Function }
 * @param { ElementName } elementName - The ohos.bundleManager.ElementName object of the service ability
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
type OnDisconnectFn = (elementName: ElementName) => void;
/**
 * The callback interface was connect failed.
 *
 * @typedef { Function }
 * @param { int } code - The error code of the failed.
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
type OnFailedFn = (code: int) => void;
/**
 * As an input parameter when connecting a specified background service, it is used to receive
 * state changes during the connection.
 *
 * @interface ConnectOptions
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
export interface ConnectOptions {
    
    /**
     * The callback interface was connect successfully.
     *
     * @type { OnConnectFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    onConnect: OnConnectFn;
    
    /**
     * The callback interface was disconnect successfully.
     *
     * @type { OnDisconnectFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    onDisconnect: OnDisconnectFn;
    /**
     * The callback interface was connect failed.
     *
     * @typedef { OnFailedFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    onFailed: OnFailedFn;
}
