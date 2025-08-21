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
 * Defines the callback that is called when state variable with value is change
 * @typedef { function } OnChangeType
 * @param {string} propertyName - property name
 * @param {T} newValue - the new value of state variable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnChangeType<T> = (propertyName: string, newValue: T) => void;

/**
 * Define AbstractProperty<T> interface.
 *
 *  AbstractProperty can be understood as a handler or an alias
 *  to a property inside LocalStorage / AppStorage singleton
 *  allows to read the value with @see get and to change the
 *  value with @see set.
 *
 * @interface AbstractProperty<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface AbstractProperty<T> {
  /**
   * Returns the name of the referenced property
   *
   * @returns { string } name of the referenced property
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   info(): string { return ""; };

  /**
   * Reads value of the referenced AppStorage/LocalStorage property.
   *
   * @returns { T } value of the referenced AppStorage/LocalStorage property.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   get(): T { return undefined; };

  /**
   * Assign a new value to the referenced property
   *
   * @param {T} newValue - a new value of the referenced property
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   set(newValue: T): void {};
  /**
   * Register callback function to be called on value change of the referenced property
   * calling with value undefined clear the callback.
   *
   * @param {OnChangeType<T> | undefined} onChangeFunc - register callback function
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
   onChange(onChangeFunc: OnChangeType<T> | undefined): void {};
}

/**
 *   SubscribedAbstractProperty<T> is the return value of
 *   - AppStorage static functions Link(), Prop(), SetAndLink(), and SetAndProp()
 *   - LocalStorage member methods link(), prop(), setAndLink(), and setAndProp()
 *   'T' can be boolean, string, number or custom class.
 * Main functions
 *   see get() reads the linked AppStorage/LocalStorage property value,
 *   see set(newValue) write a new value to the synched AppStorage/LocalStorage property
 *   see aboutToBeDeleted() ends the sync relationship with the AppStorage/LocalStorage property
 *        The app must call this function before the SubscribedAbstractProperty<T> object
 *        goes out of scope.
 *
 * @extends AbstractProperty<T>
 * @interface SubscribedAbstractProperty<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface SubscribedAbstractProperty<T> extends AbstractProperty<T> {
  /**
   * An app needs to call this function before the instance of SubscribedAbstractProperty
   * goes out of scope / is subject to garbage collection. Its purpose is to unregister the
   * variable from the two-way/one-way sync relationship that AppStorage/LocalStorage.link()/prop()
   * and related functions create.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  aboutToBeDeleted(): void {};
}