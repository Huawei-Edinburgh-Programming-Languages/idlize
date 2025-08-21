/*
 * Copyright (c) 2023-2024 Huawei Device Co., Ltd.
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
 * @kit ArkData
 */
import { AsyncCallback } from './@ohos.base';
import image from "./@ohos.multimedia.image";
import Want from "./@ohos.app.ability.Want";


/**
 * As a part of the Unified Data Management Framework (UDMF), the unifiedDataChannel module provides unified data
 * channels and standard data access interfaces for many-to-many data sharing across applications. It also provides
 * definitions for uniform data types, such as text and image, to streamline data interaction between different
 * applications and minimize the workload of data type adaptation. Although the UDMF does not parse user data, you are
 * advised not to transfer sensitive personal data or privacy data due to low-level security of storage path.
 *
 * @namespace unifiedDataChannel
 * @syscap SystemCapability.DistributedDataManager.UDMF.Core
 * @since 20
 */
declare namespace unifiedDataChannel {
    
    /**
     * Indicates type of value.
     * @typedef {number | string | boolean | image.PixelMap | Want | ArrayBuffer | object | null | undefined}
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    type ValueType = number | string | boolean | image.PixelMap | Want | ArrayBuffer | object | null | undefined;
    
    
    /**
     * Describe the unified data.
     *
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class UnifiedData {
        
        
        /**
        * Create unified data with a record
        *
        * @param { UnifiedRecord } record - Record will add into unified data.
        * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
        * <br>2.Incorrect parameters types.
        * @syscap SystemCapability.DistributedDataManager.UDMF.Core
        * @since 20
        */
        constructor(record: UnifiedRecord);
        
        /**
         * Create a empty unified data.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        constructor();
        
        
        /**
         * Add a record into unified data
         *
         * @param { UnifiedRecord } record - Record will add into unified data.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types.
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        addRecord(record: UnifiedRecord): void;
        
        
        /**
        * Get all records of unified data
        *
        * @returns { Array<UnifiedRecord> } Return the records of unified data
        * @syscap SystemCapability.DistributedDataManager.UDMF.Core
        * @since 20
        */
        getRecords(): Array<UnifiedRecord>;
    }
    
    /**
     * Summarizes the data information of the unifiedData object, including the data type and size.
     *
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Summary {
        
        /**
         * A map for each type and data size, key is data type, value is the corresponding data size
         *
         * @type { Record<string, number> }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        summary: Record<string, number>;
        
        /**
         * Total data size of data in Bytes
         *
         * @type { number }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        totalSize: number;
    }
    
    
    /**
     * An abstract definition of the data content supported by the UDMF. A UnifiedRecord object contains one or more data
     * records, for example, a text record, an image record, or an HTML record. Since API version 15, different styles of
     * the same content can be added to a UnifiedRecord object. Data users can obtain the corresponding styles as
     * required.
     *
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class UnifiedRecord {
        
        
        /**
         * Get type of unified record
         *
         * @returns { string } Return the type of unified data
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        getType(): string;
        
        /**
         * Create unified record.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        constructor();
        
        /**
         * Create unified record by type and value.
         *
         * @param { string } type - indicates to data type of unified record. It can not be empty. When type of value is
         * object, parameter type must be pixel-map or want UTD type.
         * @param { ValueType } value - indicates to value of unified record.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        constructor(type: string, value: ValueType);
        
        /**
         * Get the value of unified record.
         *
         * @returns { ValueType } Return the value of unified record.
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        getValue(): ValueType;
    }
    
    
    /**
     * Describe the unified text data
     *
     * @extends UnifiedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Text extends UnifiedRecord {
        
        
        
        /**
         * Indicates the details of unified text
         *
         * @returns { Record<string, string> | undefined } the details of unified text
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get details(): Record<string, string> | undefined;
        
        
        
        /**
         * Indicates the details of unified text
         *
         * @param { Record<string, string> } the details of unified text
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set details(value: Record<string, string>);
    }
    
    
    /**
     * Describe the unified plain text data
     *
     * @extends Text
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class PlainText extends Text {
        
        
        
        /**
         * Indicates the content of text
         *
         * @returns { string } the content of text
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get textContent(): string;
        
        
        
        /**
         * Indicates the content of text
         *
         * @param { string } the content of text
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set textContent(value: string);
        /**
         * Indicates the abstract of text
         *
         * @returns { string | undefined } the abstract of text
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get textAbstract(): string | undefined;
        /**
         * Indicates the abstract of text
         *
         * @param { string | undefined } the abstract of text
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set textAbstract(value: string | undefined);
    }
    
    
    /**
     * Describe the unified link data
     *
     * @extends Text
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Hyperlink extends Text {
        
        
        
        /**
         * Indicates the url of a link
         *
         * @returns { string } the url of a link
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get url(): string;
        
        
        
        /**
         * Indicates the url of a link
         *
         * @param { string } the url of a link
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set url(value: string);
        
        
        
        /**
         * Indicates the description of a link
         *
         * @returns { string | undefined } the description of a link.
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get description(): string | undefined;
        
        
        
        /**
         * Indicates the description of a link
         *
         * @param { string } the description of a link
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set description(value: string);
    }
    
    
    /**
     * Describe the unified html data
     *
     * @extends Text
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class HTML extends Text {
        
        
        
        /**
         * Indicates the content of html, with html tags
         *
         * @returns { string } the content of html
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get htmlContent(): string;
        
        
        
        /**
         * Indicates the content of html, with html tags
         *
         * @param { string } the content of html
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set htmlContent(value: string);
        
        
        
        /**
         * Indicates the plain content of html
         *
         * @returns { string | undefined } the plain content of html
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get plainContent(): string | undefined;
        
        
        
        /**
         * Indicates the plain content of html
         *
         * @param { string } the plain content of html
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set plainContent(value: string);
    }
    
    
    /**
     * Describe the unified file data
     *
     * @extends UnifiedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class File extends UnifiedRecord {
        
        
        
        /**
         * Indicates the details of unified File
         *
         * @returns { Record<string, string> | undefined } the details of unified File
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get details(): Record<string, string> | undefined;
        
        
        
        /**
         * Indicates the details of unified File
         *
         * @param { Record<string, string> } the details of unified File
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set details(value: Record<string, string>);
        
        
        
        /**
         * Indicates the uri of file
         *
         * @returns { string } the uri of file
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get uri(): string;
        
        
        
        /**
         * Indicates the uri of file
         *
         * @param { string } the uri of file
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set uri(value: string);
    }
    
    
    /**
     * Describe the unified image data
     *
     * @extends File
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Image extends File {
        
        
        
        /**
         * Indicates the uri of image
         *
         * @returns { string } the uri of image
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get imageUri(): string;
        
        
        
        /**
         * Indicates the uri of image
         *
         * @param { string } the uri of image
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set imageUri(value: string);
    }
    
    
    /**
     * Describe the unified video data
     *
     * @extends File
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Video extends File {
        
        
        
        /**
         * Indicates the uri of video
         *
         * @returns { string } the uri of video
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get videoUri(): string;
        
        
        
        /**
         * Indicates the uri of video
         *
         * @param { string } the uri of video
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set videoUri(value: string);
    }
    
    
    /**
     * Describe the unified audio data
     *
     * @extends File
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Audio extends File {
        
        
        
        /**
         * Indicates the uri of audio
         *
         * @returns { string } the uri of audio
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get audioUri(): string;
        
        
        
        /**
         * Indicates the uri of audio
         *
         * @param { string } the uri of audio
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set audioUri(value: string);
    }
    
    
    /**
     * Describe the unified folder data
     *
     * @extends File
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class Folder extends File {
        
        
        
        /**
         * Indicates the uri of folder
         *
         * @returns { string } the uri of folder
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get folderUri(): string;
        
        
        
        /**
         * Indicates the uri of folder
         *
         * @param { string } the uri of folder
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set folderUri(value: string);
    }
    
    /**
     * Describe system defined type data(this kind of data is provided and bound to OpenHarmony,
     * also can be parsed by system provided API)
     *
     * @extends UnifiedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class SystemDefinedRecord extends UnifiedRecord {
        
        
        /**
         * Indicates the details of system defined data
         *
         * @returns { Record<string, number | string | Uint8Array> | undefined } the details of system defined data
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get details(): Record<string, number | string | Uint8Array> | undefined;
        
        
        /**
         * Indicates the details of system defined data
         *
         * @param { Record<string, number | string | Uint8Array> } the details of system defined data
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set details(value: Record<string, number | string | Uint8Array>);
    }
    
    /**
     * Describe system defined form data(this kind of data is provided and bound to OpenHarmony,
     * also can be parsed by system provided API)
     *
     * @extends SystemDefinedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class SystemDefinedForm extends SystemDefinedRecord {
        
        
        /**
         * Indicates the id of form
         *
         * @returns { number } the id of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get formId(): number;
        
        
        /**
         * Indicates the id of form
         *
         * @param { number } the id of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set formId(value: number);
        
        
        /**
         * Indicates the name of form
         *
         * @returns { string } the name of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get formName(): string;
        
        
        /**
         * Indicates the name of form
         *
         * @param { string } the name of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set formName(value: string);
        
        
        /**
         * Indicates the bundle name of form
         *
         * @returns { string } the bundle name of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get bundleName(): string;
        
        
        /**
         * Indicates the bundle name of form
         *
         * @param { string } the bundle name of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set bundleName(value: string);
        
        
        /**
         * Indicates the ability name of form
         *
         * @returns { string } the ability name of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get abilityName(): string;
        
        
        /**
         * Indicates the ability name of form
         *
         * @param { string } the ability name of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set abilityName(value: string);
        
        
        /**
         * Indicates the module of form
         *
         * @returns { string } the module of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get module(): string;
        
        
        /**
         * Indicates the module of form
         *
         * @param { string } the module of form
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set module(value: string);
    }
    
    /**
     * Describe system defined app item data(this kind of data is provided and bound to OpenHarmony,
     * also can be parsed by system provided API)
     *
     * @extends SystemDefinedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class SystemDefinedAppItem extends SystemDefinedRecord {
        
        
        /**
         * Indicates the app id
         *
         * @returns { string } the app id
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get appId(): string;
        
        
        /**
         * Indicates the app id
         *
         * @param { string } the app id
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set appId(value: string);
        
        
        /**
        * Indicates the app name
        *
        * @returns { string } the app name
        * @syscap SystemCapability.DistributedDataManager.UDMF.Core
        * @since 20
        */
        get appName(): string;
        
        
        /**
        * Indicates the app name
        *
        * @param { string } the app name
        * @syscap SystemCapability.DistributedDataManager.UDMF.Core
        * @since 20
        */
        set appName(value: string);
        
        
        /**
         * Indicates the id of app icon
         *
         * @returns { string } the id of app icon
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get appIconId(): string;
        
        
        /**
         * Indicates the id of app icon
         *
         * @param { string } the id of app icon
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set appIconId(value: string);
        
        
        /**
         * Indicates the id of app label
         *
         * @returns { string } the id of app label
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get appLabelId(): string;
        
        
        /**
         * Indicates the id of app label
         *
         * @param { string } the id of app label
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set appLabelId(value: string);
        
        
        /**
         * Indicates the bundle name of app
         *
         * @returns { string } the bundle name of app
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get bundleName(): string;
        
        
        /**
         * Indicates the bundle name of app
         *
         * @param { string } the bundle name of app
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set bundleName(value: string);
        
        
        /**
         * Indicates the ability name of app
         *
         * @returns { string } the ability name of app
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get abilityName(): string;
        
        
        /**
         * Indicates the ability name of app
         *
         * @param { string } the ability name of app
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set abilityName(value: string);
    }
    
    /**
     * Describe system defined pixel map data(this kind of data is provided and bound to OpenHarmony,
     * also can be parsed by system provided API)
     *
     * @extends SystemDefinedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class SystemDefinedPixelMap extends SystemDefinedRecord {
        
        
        /**
         * Indicates the raw data of pixel map
         *
         * @returns { Uint8Array } the raw data of pixel map
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get rawData(): Uint8Array;
        
        
        /**
         * Indicates the raw data of pixel map
         *
         * @param { Uint8Array } the raw data of pixel map
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set rawData(value: Uint8Array);
    }
    
    /**
     * Describe application defined data(this kind of data is provided and bound to OpenHarmony,
     * also can be parsed by system provided API)
     *
     * @extends UnifiedRecord
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    class ApplicationDefinedRecord extends UnifiedRecord {
        
        
        /**
         * Indicates the type of data, should always be started with 'ApplicationDefined.', will
         * return error otherwise
         *
         * @returns { string }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get applicationDefinedType(): string;
        
        
        /**
         * Indicates the type of data, should always be started with 'ApplicationDefined.', will
         * return error otherwise
         *
         * @oaram { string }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set applicationDefinedType(value: string);
        
        
        /**
         * Indicates the raw data of application defined data
         *
         * @returns { Uint8Array }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        get rawData(): Uint8Array;
        
        
        /**
         * Indicates the raw data of application defined data
         *
         * @param { Uint8Array }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        set rawData(value: Uint8Array);
    }
    
    /**
     * Describe the sharing channel that UDMF support
     *
     * @enum { string }
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    enum Intention {
        
        /**
         * Indicates the intention of data hub
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        DATA_HUB = 'DataHub'
    }
    
    
    /**
     * Describe the optional arguments of data operation
     *
     * @typedef { Options }
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    interface Options {
        
        
        /**
         * Indicates the target Intention
         *
         * @type { ?Intention }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        intention?: Intention;
        
        
        /**
         * Indicates the unique identifier of target UnifiedData
         *
         * @type { ?string }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        key?: string;
    }
    /**
     * Defines the types of file conflict options when getting data from the UDMF.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    enum FileConflictOptions {
        /**
         * Overwrite when destUri has file with same name.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        OVERWRITE,
        /**
         * Skip when destUri has file with same name.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        SKIP
    }
    /**
     * Defines the types of progress indicator when getting data from the UDMF.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    enum ProgressIndicator {
        /**
         * Getting data without system default progress indicator.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        NONE,
        /**
         * Getting data with system default progress indicator.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        DEFAULT
    }
    /**
     * Defines the listener status of obtaining progress and data.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    enum ListenerStatus {
        /**
         * Indicates the finished status.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        FINISHED = 0,
        /**
         * Indicates that processing is still in progress.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        PROCESSING,
        /**
         * Indicates that the process has been canceled.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        CANCELED,
        /**
         * Indicates that an internal error has occurred.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        INNER_ERROR = 200,
        /**
         * Indicates that the GetDataParams contains invalid parameters.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        INVALID_PARAMETERS,
        /**
         * Indicates that no data is obtained.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        DATA_NOT_FOUND,
        /**
         * Indicates that an error occurred in the synchronization process.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        SYNC_FAILED,
        /**
         * Indicates that an error occurred during file copying.
         *
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        COPY_FILE_FAILED
    }
    /**
     * Indicates the progress information.
     *
     * @interface ProgressInfo
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    interface ProgressInfo {
        /**
         * Indicates the UDMF processing progress.
         *
         * @type { number }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        progress: number;
        /**
         * Indicates the status of obtaining progress and data.
         *
         * @type { ListenerStatus }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        status: ListenerStatus;
    }
    /**
     * A listener callback function that fetches progress info and data.
     *
     * @typedef { function } DataProgressListener
     * @param { ProgressInfo } progressInfo - the progress information.
     * @param { UnifiedData | null } data - Data obtained when the progress reaches 100%.
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    type DataProgressListener = (progressInfo: ProgressInfo, data: UnifiedData | null) => void;
    /**
     * Represents the get data parameters when getting data from udmf.
     *
     * @interface GetDataParams
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    interface GetDataParams {
        /**
         * Indicates whether to use default system progress indicator.
         *
         * @type { ProgressIndicator }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        progressIndicator: ProgressIndicator;
        /**
         * Indicates progress and data listener when getting unified data.
         *
         * @type { DataProgressListener }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        dataProgressListener: DataProgressListener;
        /**
         * Indicates the dest path uri where copy file will be copied to sandbox of application.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        destUri?: string;
        /**
         * Indicates file conflict options when dest path has file with same name.
         *
         * @type { FileConflictOptions }
         * @syscap SystemCapability.DistributedDataManager.UDMF.Core
         * @since 20
         */
        fileConflictOptions?: FileConflictOptions;
    }
    
    /**
     * Insert data into unified data channel by Intention
     *
     * @param { Options } options - fill the intention field to indicate the target {@link Intention}.
     * @param { UnifiedData } data - {@link UnifiedData} data object to insert into target intention.
     * @param { AsyncCallback<string> } callback - {string}: the unique identifier.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    function insertData(options: Options, data: UnifiedData, callback: AsyncCallback<string>): void;
    
    /**
     * Insert data into unified data channel by Intention
     *
     * @param { Options } options - fill the intention field to indicate the target {@link Intention}.
     * @param { UnifiedData } data - {@link UnifiedData} data object to insert into target intention.
     * @returns { Promise<string> } {string}: the unique identifier.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    function insertData(options: Options, data: UnifiedData): Promise<string>;
    
    /**
     * Query data of unified data channel by Intention or Unique Identifier
     *
     * @param { Options } options - fill the intention or unique identifier field to indicate the target {@link Intention}
     * or {@link UnifiedData}.
     * @param { AsyncCallback<Array<UnifiedData>> } callback - {Array<UnifiedData>}: the target {@link UnifiedData} object
     *  array.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    function queryData(options: Options, callback: AsyncCallback<Array<UnifiedData>>): void;
    
    /**
     * Query data of unified data channel by Intention or Unique Identifier
     *
     * @param { Options } options - fill the intention or unique identifier field to indicate the target {@link Intention}
     * or {@link UnifiedData}.
     * @returns { Promise<Array<UnifiedData>> } {Array<UnifiedData>}: the target {@link UnifiedData} object array.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types.
     * @syscap SystemCapability.DistributedDataManager.UDMF.Core
     * @since 20
     */
    function queryData(options: Options): Promise<Array<UnifiedData>>;
}
export default unifiedDataChannel;
