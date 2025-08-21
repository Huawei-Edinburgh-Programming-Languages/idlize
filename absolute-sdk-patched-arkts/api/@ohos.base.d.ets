/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
 
/**
 * Defines the basic callback.
 *
 * @typedef { Callback<T> }
 * @syscap SystemCapability.Base
 * @since 20
 */
 export type Callback<T> = (data: T) => void;

 /**
  * Defines the basic error callback.
  *
  * @typedef { ErrorCallback<T extends Error = BusinessError> }
  * @syscap SystemCapability.Base
  * @since 20
  */
 export type ErrorCallback<T extends Error = BusinessError> = (err: T)=> void;
 
 /**
  * Defines the basic async callback.
  *
  * @typedef { AsyncCallback<T, E = void> }
  * @syscap SystemCapability.Base
  * @since 20
  */
 export type AsyncCallback<T, E = void> = (err: BusinessError<E> | null, data: T | undefined)=> void;
 
 /**
  * Defines the error interface.
  * @syscap SystemCapability.Base
  * @since 20
  */
 export declare class BusinessError<T = void> extends Error {
   /**
   * A constructor used to create a BusinessError object
   * @syscap SystemCapability.Base
   * @since 20
   */
   constructor();
   /**
   * A constructor used to create a BusinessError object
   * @param { int } code
   * @param { Error } error
   * @syscap SystemCapability.Base
   * @since 20
   */
   constructor(code: int, error: Error);
   /**
   * A constructor used to create a BusinessError object
   * @param { int } code
   * @param { T } data
   * @param { Error } error
   * @syscap SystemCapability.Base
   * @since 20
   */
   constructor(code: int, data: T, error: Error);
 
    /**
    * Defines the basic error code.
    * @type { int } code
    * @syscap SystemCapability.Base
    * @since 20
    */
   code: int;
    /**
    * Defines the additional information for business
    * @type { ?T } data
    * @syscap SystemCapability.Base
    * @since 20
    */
   data?: T;
 }
 
 /**
  * In ArkTS static typing, for literals where the hierarchy and the number
  * of attributes per level are uncertain, you can use RecordData for initialization.
  * @typedef RecordData
  * @syscap SystemCapability.Base
  * @since 20
  * @example
  * import { RecordData } from '@kit.BasicServiceKit';
  * const param: RecordData = {
  *   "key": {
  *   "a": 1
  *   }
  * }
  * let want: Want = {
  *   bundleName: 'com.example.myapplication',
  *   abilityName: 'EntryAbility',
  *   parameters: param
  * };
  * this.context.startAbility(want);
  */
 export type RecordData = undefined | null | Object | Record<string, RecordData> | Array<RecordData>;
 