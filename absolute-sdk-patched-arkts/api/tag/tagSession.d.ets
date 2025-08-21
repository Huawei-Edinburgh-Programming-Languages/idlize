/*
 * Copyright (c) 2021-2022 Huawei Device Co., Ltd.
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
 * @kit ConnectivityKit
 */
import tag from '../@ohos.nfc.tag';
import { AsyncCallback } from '../@ohos.base';

/**
 * Controls tag read and write.
 * <p>Classes for different types of tags inherit from this abstract class to control connections to
 * tags, read data from tags, and write data to tags.
 *
 * @typedef TagSession
 * @syscap SystemCapability.Communication.NFC.Tag
 * @since 20
 */
export interface TagSession {
    
    /**
     * Connects to a tag. Must be called before data is read from or written to the tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    connect(): void;
    
    /**
     * Resets a connection with a tag and restores the default timeout duration for writing data to the tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    resetConnection(): void;
    
    /**
     * Checks whether a connection has been set up with a tag.
     *
     * @returns { boolean } Returns true if tag connected, otherwise false.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    isConnected(): boolean;
    
    /**
     * Sets the timeout duration (ms) for sending data to a tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @param { int } timeout Indicates the timeout duration to be set.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    setTimeout(timeout: int): void;
    
    /**
     * Obtains the timeout duration (ms) for sending data to a tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @returns { int } Returns the timeout duration.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    getTimeout(): int;
    
    /**
     * Writes data to a tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @param { int[] } data Indicates the data to be written to the tag.
     * @returns { Promise<int[]> } Returns bytes received in response. Or bytes with a length of 0 if the
     * data fails to be written to the tag.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @throws { BusinessError } 3100204 - The tag I/O operation failed.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    transmit(data: int[]): Promise<int[]>;
    
    /**
     * Writes data to a tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @param { int[] } data Indicates the data to be written to the tag.
     * @param { AsyncCallback<int[]> } callback The callback.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @throws { BusinessError } 3100204 - The tag I/O operation failed.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    transmit(data: int[], callback: AsyncCallback<int[]>): void;
    
    /**
     * Obtains the maximum length of data that can be sent to a tag.
     *
     * @permission ohos.permission.NFC_TAG
     * @returns { int } Returns the maximum length of the data to be sent to the tag.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100201 - The tag running state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Tag
     * @since 20
     */
    getMaxTransmitSize(): int;
}
