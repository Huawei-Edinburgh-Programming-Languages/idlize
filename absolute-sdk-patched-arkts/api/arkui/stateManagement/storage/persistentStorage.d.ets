'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */

/**
 * Defines the PersistentStorage interface.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PersistentStorage {
  /**
   * Add property 'key' to AppStorage properties whose current value will be
   * persistent.
   * If AppStorage does not include this property it will be added and initializes
   * with given value
   *
   * @param { string } key - property name
   * @param { T } defaultValue - If AppStorage does not include this property it will be initialized with this value
   * @param { ToJSONType<T> } [toJson] - serialization function
   * @param { FromJSONType<T> } [fromJson] - deserialization function
   * @returns { boolean }
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static persistProp<T>(key: string, defaultValue: T, toJson?: ToJSONType<T>, fromJson?: FromJSONType<T>): boolean;

  /**
   * Reverse of @see persistProp
   *
   * @param { string } key - no longer persist the property named key
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static deleteProp(key: string): void;

  /**
   * Inform persisted AppStorage property names
   *
   * @returns { Array<string> } array of AppStorage keys
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static keys(): Array<string>;
}

/**
 * Define toJson type function.
 *
 * @typedef { function } ToJSONType<T>
 * @param { T } value  toJson value
 * @returns { jsonx.JsonElement } Json stringify element object
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare type ToJSONType<T> = (value: T) => jsonx.JsonElement;

/**
 * Define fromJson type function.
 *
 * @typedef { function } FromJSONType<T>
 * @param { jsonx.JsonElement } element  json element
 * @returns { T } deserialization result
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare type FromJSONType<T> = (element: jsonx.JsonElement) => T;