/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
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

import { Builder } from './builder';
import { ComponentBuilder } from './../stateManagement/runtime';

/**
 * Indicates the type of Repeat's Data Source.
 *
 * @typedef { Array<T> | ReadonlyArray<T> | Readonly<Array<T>> }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type RepeatArray<T> = Array<T> | ReadonlyArray<T> | Readonly<Array<T>>;
/**
 * Function that return typed string to render one template.
 *
 * @typedef {function} TemplateTypedFunc<T>
 * @param { T } item - data item.
 * @param { number } index - data index number in array.
 * @returns { string } template type.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type TemplateTypedFunc<T> = (item: T, index: number) => string;
/**
 * Define builder function to render one template type.
 *
 * @typedef {function} RepeatItemBuilder<T>
 * @param { RepeatItem<T> } repeatItem - the repeat item builder function.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Builder
type RepeatItemBuilder<T> = (repeatItem: RepeatItem<T>) => void;

/**
 * Construct a new type for each item.
 *
 * @interface RepeatItem
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RepeatItem<T> {
  /**
   * The origin data.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  item: T;
  /**
   * index of each item.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  index: number;
}

/**
 * Function that is used to do lazy loading.
 *
 * @typedef {function} OnLazyLoadingFunc
 * @param { number } index - data index.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type OnLazyLoadingFunc = (index: number) => void;

/**
 * Define key generator function.
 *
 * @typedef {function} KeyGeneratorFunc<T>
 * @param { T } item - data item.
 * @param { number } index - data index number in array.
 * @returns { string } key value.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type KeyGeneratorFunc<T> = (item: T, index: number) => string;

/**
 * Function that is used to get total count.
 *
 * @typedef {function} OnTotalCountFunc
 * @returns { number } Returns the total data count
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
type OnTotalCountFunc = () => number;

/**
 * Define the options of repeat virtualScroll to implement reuse and lazy loading.
 *
 * @interface VirtualScrollOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface VirtualScrollOptions {
  /**
   * Total data count.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  totalCount?: number;
  /**
   * Reuse or not.
   *
   * @type { ?boolean }
   * @default true
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reusable?: boolean;
  /**
   * Data lazy loading
   *
   * @type { ?OnLazyLoadingFunc }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onLazyLoading?: OnLazyLoadingFunc;
  /**
   * The function of total data count.
   *
   * @type { ?OnTotalCountFunc }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onTotalCount?: OnTotalCountFunc;
  /**
   * Indicates whether to activate virtual scroll mode.
   *
   * @type { ?boolean }
   * @default false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  disableVirtualScroll?: boolean;
}

/**
 * Define a builder template option parameter.
 *
 * @interface TemplateOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface TemplateOptions {
  /**
   * The cached number of each template.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  cachedCount?: number;
}

/**
 * Defines the Repeat component attribute functions.
 *
 * @typedef RepeatAttribute<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RepeatAttribute<T> {
  /**
   * Executes itemGenerator of each item.
   *
   * @param { RepeatItemBuilder<T> } itemGenerator
   * @returns { this } RepeatAttribute instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  each(itemGenerator: RepeatItemBuilder<T>): this;
  /**
   * Obtains key of each item.
   *
   * @param { KeyGeneratorFunc<T> } keyGenerator
   * @returns { this } RepeatAttribute instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  key(keyGenerator: KeyGeneratorFunc<T>): this;
  /**
   * Enable UI lazy loading when scroll up or down.
   *
   * @param { VirtualScrollOptions } [virtualScrollOptions] that defines the options of repeat virtual scroll to
   *     implement reuse and lazy loading.
   * @returns { this } RepeatAttribute instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  virtualScroll(virtualScrollOptions?: VirtualScrollOptions): this;
  /**
   * Type builder function to render specific type of data item.
   *
   * @param { string } type that defines the template id.
   * @param { RepeatItemBuilder<T> } itemBuilder that defines UI builder function.
   * @param { TemplateOptions } [templateOptions] that defines a builder template option parameter.
   * @returns { this } RepeatAttribute instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  template(type: string, itemBuilder: RepeatItemBuilder<T>, templateOptions?: TemplateOptions): this;
  /**
   * Typed function to render specific type of data item.
   *
   * @param { TemplateTypedFunc<T> } typedFunc that define template typed function.
   * @returns { this } RepeatAttribute instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  templateId(typedFunc: TemplateTypedFunc<T>): this;
}

/**
 * Indicates the type of Repeat.
 *
 * @param { RepeatArray<T> } arr - The Data Source
 * @returns { RepeatAttribute<T> }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@ComponentBuilder
export declare function Repeat<T>(arr: RepeatArray<T>): RepeatAttribute<T>;