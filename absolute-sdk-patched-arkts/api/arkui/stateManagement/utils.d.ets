'use static'
/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */

/**
 * UIUtils is a state management tool class for operating the observed data.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class UIUtils {
  /**
   * Get raw object from the Object, like builtin type, objectLiteral.
   * If input parameter is a regular Object without proxy, return Object itself.
   *
   * @param { T } source input source Object data.
   * @returns { T } raw object.
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static getTarget<T extends object>(source: T): T;

  /**
   * Make non-observed data into observed data.
   * Support builtin type and objectLiteral.
   *
   * @param { T } source input source object data.
   * @returns { T } proxy object from the source object data.
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   static makeObserved<T extends object>(source: T): T;

   /**
   * Creates read-only data binding.
   *
   *
   * Example. UIUtils.makeBinding<number>(()=>this.num);
   *
   * Supports simple getters for read-only data.
   * Intended for primitive value parameters when calling a @Builder function where arguments are of type Binding.
   *
   * @param { GetterCallback<T> } getter - A value or a function that returns the current value of type T.
   * @returns { Binding<T> } read-only data binding value
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static makeBindingReadonly<T>(getter: GetterCallback<T>): Binding<T>;

  /**
   * Creates a mutable data binding.
   *
   * Two functions to implement function overloading.
   *
   * Example. UIUtils.makeBinding<number>(()=>this.num, val => this.num = val);
   *
   * Supports getter-setter pairs for mutable data.
   * Intended for primitive value parameters when calling a @Builder
   * function where arguments are of type MutableBinding.
   *
   * @param { GetterCallback<T> } getter - A value or a function that returns the current value of type T.
   * @param { SetterCallback<T> } setter - A function to set a new value of type T. 
   * If provided, a MutableBinding is created.
   * @returns { MutableBinding<T> } mutable data binding value
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static makeBindingMutable<T>(getter: GetterCallback<T>, setter: SetterCallback<T>): MutableBinding<T>;

  /**
   * Creates data binding.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static overload makeBinding { makeBindingReadonly, makeBindingMutable }
}

/**
 * Getter callback type. It is used to get value.
 *
 * @typedef { function } GetterCallback
 * @returns { T }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare type GetterCallback<T> = () => T;

/**
 * Setter callback type. It is used to assign a new value.
 *
 * @typedef { function } SetterCallback
 * @param { T } newValue - update the value with newValue.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare type SetterCallback<T> = (newValue: T) => void;

/**
 * Represents a read-only data binding.
 * Use with @Builder argument list for primitive types. Use makeBinding to pass values when calling the function.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class Binding<T> {
  /**
   * Get function that can acquire the value.
   * @returns T
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get value(): T;
}

/**
 * Represents a mutable data binding allowing both read and write operations.
 * Use with @Builder argument list for primitive types. Use makeBinding to pass values when calling the function.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class MutableBinding<T> {
  /**
   * Get function that can acquire the value.
   * @returns T
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get value(): T;
  /**
   * Set function that can set the new value.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set value(newValue: T);
}