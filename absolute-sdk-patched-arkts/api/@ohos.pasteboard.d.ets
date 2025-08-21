/*
 * Copyright (c) 2021-2025 Huawei Device Co., Ltd.
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
 * @kit BasicServicesKit
 */
import { AsyncCallback } from './@ohos.base';
import Want from './@ohos.app.ability.Want';
import image from './@ohos.multimedia.image';
import unifiedDataChannel from './@ohos.data.unifiedDataChannel';

/**
 * systemPasteboard
 * @namespace pasteboard
 * @syscap SystemCapability.MiscServices.Pasteboard
 * @since 20
 */
declare namespace pasteboard {
    
    /**
     * Indicates MIME types of HTML text.
     * @constant
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    const MIMETYPE_TEXT_HTML = 'text/html';
    
    /**
     * Indicates MIME types of plain text.
     * @constant
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    const MIMETYPE_TEXT_PLAIN = 'text/plain';
    
    /**
     * Indicates MIME types of URIs.
     * @constant
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    const MIMETYPE_TEXT_URI = 'text/uri';
    
    /**
     * Indicates type of value.
     * @typedef { string | image.PixelMap | Want | ArrayBuffer }
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    type ValueType = string | image.PixelMap | Want | ArrayBuffer;
    
    /**
     * Creates a PasteData object of the specified type.
     * @param { string } mimeType - indicates MIME type of value, its size cannot be greater than 1024 bytes.
     * @param { ValueType } value - indicates the content that is set to PasteData.
     * @returns { PasteData } a new PasteData object which contains mimeType and value.
     * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
     *    2. Incorrect parameters types;
     *    3. Parameter verification failed.
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    function createData(mimeType: string, value: ValueType): PasteData;
    /**
     * Creates a PasteData object with the specified MIME types and values.
     * @param { Record<string, ValueType> } data - indicates the MEME types and values of the PasteData object to create.
     * @returns { PasteData } Returns the PasteData object created.
     * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
     *    2. Incorrect parameters types;
     *    3. Parameter verification failed.
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    function createData(data: Record<string, ValueType>): PasteData;
    
    /**
     * get SystemPasteboard
     * @returns { SystemPasteboard } The system clipboard object
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    function getSystemPasteboard(): SystemPasteboard;
    
    /**
     * Types of scope that PasteData can be pasted.
     * @enum { number }
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    enum ShareOption {
        
        /**
         * INAPP indicates that only intra-application pasting is allowed.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        INAPP,
        
        /**
         * LOCALDEVICE indicates that paste is allowed in any application.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        LOCALDEVICE
    }
    /**
     * Enumerates the patterns allowed in the system pasteboard.
     * @enum { number }
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    enum Pattern {
        /**
         * URL pattern.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        URL = 0,
        /**
         * Number pattern.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        NUMBER = 1
    }
    
    /**
     * Defines the properties of all data records on the pasteboard, including the timestamp, data type, pasteable range,
     * and additional data. The defined properties can be applied to the pasteboard only with the setProperty method.
     * @interface PasteDataProperty
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    interface PasteDataProperty {
        
        /**
         * the user-defined tag of a PasteData object.
         * @type { string }
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        tag: string;
        
        /**
         * a timestamp, which indicates when data is written to the system pasteboard.
         * @type { long }
         * @readonly
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        readonly timestamp: long;
        
        /**
         * Indicates the scope of clipboard data which can be pasted.
         * If it is not set or is incorrectly set, The default value is CrossDevice.
         * @type { ShareOption }
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        shareOption: ShareOption;
    }
    
    /**
     * Paste data record.
     * @interface PasteDataRecord
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    interface PasteDataRecord {
        
        /**
         * MIME types of a record.
         * @type { string }
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        mimeType: string;
        
        /**
         * plain text in a record.
         * @type { string }
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        plainText: string;
        
        /**
         * an URI in a record.
         * @type { string }
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        uri: string;
        
        /**
         * PixelMap in a record.
         * @type { image.PixelMap }
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        pixelMap: image.PixelMap;
        
        /**
         * Converts data in PasteData to text format.
         * @returns { string } the string returned by the function.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        toPlainText(): string;
        /**
         * Obtains data of the specified type.
         * @param { string } type - indicates the type of the data to obtain.
         * @returns { Promise<ValueType> } Promise used to return the data obtained.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types;
         *    3. Parameter verification failed.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getData(type: string): Promise<ValueType>;
    }
    
    /**
     * Classes for paste data.
     * @interface PasteData
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    interface PasteData {
        
        /**
         * Adds a PasteRecord to a PasteData object and updates MIME types in DataProperty.
         * @param { PasteDataRecord } record - The content of a new record.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        addRecord(record: PasteDataRecord): void;
        
        
        /**
         * Adds a record with mimeType and value to a PasteData object.
         * @param { string } mimeType - indicates the MIME type of value, its size cannot be greater than 1024 bytes.
         * @param { ValueType } value - content to be saved.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types;
         *    3. Parameter verification failed.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        addRecord(mimeType: string, value: ValueType): void;
        
        /**
         * MIME types of all content on the pasteboard.
         * @returns { Array<string> } type of array
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getMimeTypes(): Array<string>;
        
        /**
         * HTML text of the primary record in a PasteData object.
         * @returns { string } type of htmltext
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getPrimaryHtml(): string;
        
        /**
         * the want of the primary record in a PasteData object.
         * @returns { Want } type of want
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getPrimaryWant(): Want;
        
        /**
         * the MIME type of the primary record in a PasteData object.
         * @returns { string } type of mimetype
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getPrimaryMimeType(): string;
        
        /**
         * the plain text of the primary record in a PasteData object.
         * @returns { string } type of text
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getPrimaryText(): string;
        
        /**
         * the URI of the primary record in a PasteData object.
         * @returns { string } type of uri
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getPrimaryUri(): string;
        
        /**
         * DataProperty of a PasteData object.
         * @returns { PasteDataProperty } PasteDataProperty type of PasteDataProperty
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getProperty(): PasteDataProperty;
        
        /**
         * Sets PasteDataProperty to a PasteData object, Modifying shareOption is supported only.
         * @param { PasteDataProperty } property - save property to PasteData object.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        setProperty(property: PasteDataProperty): void;
        
        /**
         * Gets record by index in PasteData.
         * @param { int } index - indicates the record index in PasteData.
         * @returns { PasteDataRecord } the record in PasteData with index.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @throws { BusinessError } 12900001 - The index is out of the record.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getRecord(index: int): PasteDataRecord;
        
        /**
         * the number of records in a PasteData object.
         * @returns { int } The number of the clipboard contents
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getRecordCount(): int;
        
        /**
         * the user-defined tag of a PasteData object.
         * @returns { string } type of tag
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getTag(): string;
    }
    
    /**
     * Classes for system pasteboard.
     * @interface SystemPasteboard
     * @syscap SystemCapability.MiscServices.Pasteboard
     * @since 20
     */
    interface SystemPasteboard {
        /**
         * Callback invoked when pasteboard content changes.
         * @param { 'update' } type - indicates pasteboard content changed.
         * @param { function } callback - the callback to add.
         * @throws { BusinessError }  401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        on(type: 'update', callback: () => void): void;
        /**
         * Remove a callback invoked when pasteboard content changes.
         * @param { 'update' } type - indicates pasteboard content changed.
         * @param { function } [callback] - the callback to remove. If this parameter is not filled in, it indicates that all
         * callbacks for this application will be cleared. Otherwise, it indicates that the specified callback will be cleared.
         * @throws { BusinessError }  401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        off(type: 'update', callback?: () => void): void;
        /**
         * Obtains the application bundle name of the data source.
         * @returns { string }  Application bundle name of the data source.
         * @throws { BusinessError } 12900005 - Excessive processing time for internal data.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getDataSource(): string;
        /**
         * Checks whether there is a specified MIME type of data in Data.
         * @param { string } mimeType - indicates to query data type.
         * @returns { boolean } if having mimeType in PasteData returns true, else returns false.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @throws { BusinessError } 12900005 - Excessive processing time for internal data.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        hasDataType(mimeType: string): boolean;
        
        /**
         * Clears the pasteboard.
         * @param { AsyncCallback<void> } callback - the callback of clearData.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        clearData(callback: AsyncCallback<void>): void;
        
        /**
         * Clears the pasteboard.
         * @returns { Promise<void> } the promise returned by the clearData.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        clearData(): Promise<void>;
        /**
         * Clears the pasteboard.
         * @throws { BusinessError } 12900005 - Excessive processing time for internal data.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        clearDataSync(): void;
        
        
        /**
         * Gets pastedata from the system pasteboard.
         * @permission ohos.permission.READ_PASTEBOARD
         * @param { AsyncCallback<PasteData> } callback - the callback of getData.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the
         *    permission required to call the API.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect  parameters types.
         * @throws { BusinessError } 27787277 - Another copy or paste operation is in progress.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getData(callback: AsyncCallback<PasteData>): void;
        
        
        /**
         * Gets pastedata from the system pasteboard.
         * @permission ohos.permission.READ_PASTEBOARD
         * @returns { Promise<PasteData> } the promise returned by the getData.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the
         *    permission required to call the API.
         * @throws { BusinessError } 27787277 - Another copy or paste operation is in progress.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getData(): Promise<PasteData>;
        
        /**
         * Gets pasteData from the system pasteboard.
         * @permission ohos.permission.READ_PASTEBOARD
         * @returns { PasteData }  a new PasteData.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the
         *    permission required to call the API.
         * @throws { BusinessError } 12900005 - Excessive processing time for internal data.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getDataSync(): PasteData;
        
        /**
         * Checks whether there is content in the system pasteboard.
         * @param { AsyncCallback<boolean> } callback - the callback of hasData.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect  parameters types.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        hasData(callback: AsyncCallback<boolean>): void;
        
        /**
         * Checks whether there is content in the system pasteboard.
         * @returns { Promise<boolean> } the promise returned by the function.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        hasData(): Promise<boolean>;
        /**
         * Checks whether there is content in the system pasteboard.
         * @returns { boolean } True exists, false does not exist.
         * @throws { BusinessError } 12900005 - Excessive processing time for internal data.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        hasDataSync(): boolean;
        
        /**
         * Writes PasteData to the system pasteboard.
         * @param { PasteData } data - PasteData will be written to the clipboard
         * @param { AsyncCallback<void> } callback - the callback of setData.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect parameters types.
         * @throws { BusinessError } 27787277 - Another copy or paste operation is in progress.
         * @throws { BusinessError } 27787278 - Replication is prohibited.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        setData(data: PasteData, callback: AsyncCallback<void>): void;
        
        /**
         * Writes PasteData to the system pasteboard.
         * @param { PasteData } data - PasteData will be written to the clipboard.
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 401 - Possible causes: 1. Mandatory parameters are left unspecified;
         *    2. Incorrect  parameters types.
         * @throws { BusinessError } 27787277 - Another copy or paste operation is in progress.
         * @throws { BusinessError } 27787278 - Replication is prohibited.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        setData(data: PasteData): Promise<void>;
        /**
         * Get the MIME types in the pasteboard.
         *
         * @returns { Promise<Array<string>> } Promise used to return the MIME types.
         * @syscap SystemCapability.MiscServices.Pasteboard
         * @since 20
         */
        getMimeTypes(): Promise<Array<string>>;
    }
}
export default pasteboard;
