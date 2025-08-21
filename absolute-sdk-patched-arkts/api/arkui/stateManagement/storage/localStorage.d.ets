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

import { AbstractProperty, SubscribedAbstractProperty } from './storageProperty';

/**
 * LocalStorage
 * Class implements a Map of ObservableObjectBase UI state variables.
 * Instances can be created to manage UI state within a limited "local"
 * access, and life cycle as defined by the app.
 * AppStorage singleton is sub-class of LocalStorage for
 * UI state of app-wide access and same life cycle as the app.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class LocalStorage {
  /**
   * Construct new instance of LocalStorage
   * initialize with all properties and their values that Object.keys(params) returns
   * Property values must not be undefined.
   *
   * @param { Record<string, Any> } [initializingProperties] - Record<string, Any> 
   * containing keys and values. 
   * see set() for valid values
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public constructor(initializingProperties?: Record<string, Any>);
  /**
   * Obtain a handler or an alias to LocalStorage property with given name.
   *
   * @param { string } propName LocalStorage property name
   * @returns { AbstractProperty<T> | undefined } AbstractProperty object if property with given name exists
   * return undefined otherwise.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public ref<T>(propName: string): AbstractProperty<T> | undefined;
  /**
   * Obtain a handler or an alias to LocalStorage property with given name.
   *
   * If property does not exist in LocalStorage, create it with given default value.
   *
   * @param { string } propName LocalStorage property name
   * @param { T } defaultValue If property does not exist in LocalStorage,
   *        create it with given default value.pe
   * @returns { AbstractProperty<T> } AbstractProperty object
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public setAndRef<T>(propName: string, defaultValue: T): AbstractProperty<T>;
  /**
   * Create and return a two-way sync "(link") to named property
   *
   * @param { string } propName - name of source property in LocalStorage
   * @returns { SubscribedAbstractProperty<T> | undefined } instance of  SubscribedAbstractProperty<T>
   *           return undefined if named property does not already exist in LocalStorage
   *           Apps can use SDK functions of base class SubscribedPropertyAbstract<T>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @since 20
   */
  public link<T>(propName: string): SubscribedAbstractProperty<T> | undefined;

  /**
   * Like see link(), but will create and initialize a new source property in LocalStorage if missing
   *
   * @param { string } propName - name of source property in LocalStorage
   * @param { T } defaultValue - value to be used for initializing new property in LocalStorage
   *        default value must be of type T, can be undefined or null.
   * @returns { SubscribedAbstractProperty<T> } instance of  SubscribedAbstractProperty<T>
   *          Apps can use SDK functions of base class SubscribedAbstractProperty<T>
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public setAndLink<T>(propName: string, defaultValue: T): SubscribedAbstractProperty<T>;

  /**
   * Check if LocalStorage has a property with given name
   * return true if property with given name exists
   * same as ES6 Map.prototype.has()
   *
   * @param { string } propName - searched property
   * @returns { boolean } true if property with such name exists in LocalStorage
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public has(propName: string): boolean;
  /**
   * Returns value of given property
   * return undefined if no property with this name
   *
   * @param { string } propName - property name
   * @returns { T | undefined } property value if found or undefined
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public get<T>(propName: string): T | undefined;
  /**
   * Set value of given property in LocalStorage
   * Method sets nothing and returns false if property with this name does not exist in LocalStorage
   * newValue can be undefined or null from API 20.
   *
   * @param { string } propName
   * @param { T } newValue - must be of type T, can be undefined or null
   * @returns { boolean } true on success, i.e. when above conditions are satisfied, otherwise false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public set<T>(propName: string, newValue: T): boolean;
  /**
   * Set value of given property, if it exists, see set() .
   * Add property if no property with given name and initialize with given value.
   * newValue can be undefined or null from API 12
   *
   * @param { string } propName
   * @param { T } newValue - must be of type T, can be undefined or null
   * @returns { boolean } true on success, i.e. when above conditions are satisfied, otherwise false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public setOrCreate<T>(propName: string, newValue: T): boolean;
  /**
   * Provide names of all properties in LocalStorage
   * same as ES6 Map.prototype.keys()
   *
   * @returns { IterableIterator<string> } return a Map Iterator
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public keys(): IterableIterator<string>;
  /**
   * Returns number of properties in LocalStorage
   * same as Map.prototype.size()
   *
   * @returns { number } return number of properties
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public size(): number;
  /**
   * Delete property from StorageBase
   * Use with caution:
   * Before deleting a prop from LocalStorage all its subscribers need to
   * unsubscribe from the property.
   * This method fails and returns false if given property still has subscribers
   * Another reason for failing is unknown property.
   * Developer advise:
   * Subscribers are created with see link(), see prop()
   * and also via @LocalStorageLink and @LocalStorageProp state variable decorators.
   * That means as long as their is a @Component instance that uses such decorated variable
   * or a sync relationship with a SubscribedAbstractProperty variable the property can nit
   * (and also should not!) be deleted from LocalStorage.
   *
   * @param { string } propName
   * @returns { boolean } false if method failed
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public delete(propName: string): boolean;
  /**
   * Delete all properties from the LocalStorage instance
   * Precondition is that there are no subscribers.
   * method returns false and deletes no properties if there is any property
   * that still has subscribers
   *
   * @returns { boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public clear(): boolean;
}