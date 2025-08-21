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
 * @kit ArkTS
 */


/**
 * HashMap is a map implemented based on the array, linked list, and red-black tree. It provides efficient data query, insertion,
 * and removal. The elements in a HashMap instance are mappings of key-value pairs. Each key must be unique and have only one value.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class HashMap<K, V> {
    
    
    /**
     * A constructor used to create a HashMap instance.
     *
     * @throws { BusinessError } 10200012 - The HashMap's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
     * Gets the number of elements in a hash map.
     *
     * @type { int }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get length(): int;
    
    
    /**
     * Checks whether this container is empty (contains no element).
     *
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The isEmpty method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;
    
    
    /**
     * Checks whether this container contains the specified key.
     *
     * @param { K } key - Target key.
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The hasKey method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    hasKey(key: K): boolean;
    
    
    /**
     * Checks whether this container contains the specified value.
     *
     * @param { V } value - Target value.
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The hasValue method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    hasValue(value: V): boolean;
    /**
     * Obtains the value of the specified key in this container. If nothing is obtained, undefined is returned.
     *
     * @param { K } key - Target key.
     * @returns { V | undefined } value or undefined
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get(key: K): V | undefined;
    
    
    /**
     * Adds all elements in a HashMap instance to this container.
     *
     * @param { HashMap<K, V> } map - HashMap instance whose elements are to be added to the current container.
     * @throws { BusinessError } 10200011 - The setAll method cannot be bound.
     * @throws { BusinessError } 401 -  Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    setAll(map: HashMap<K, V>): void;
    
    
    /**
     * Adds or updates an element in this container.
     *
     * @param { K } key - Key of the target element.
     * @param { V } value - Value of the target element.
     * @returns { Object } the map object after set
     * @throws { BusinessError } 10200011 - The set method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    set(key: K, value: V): Object;
    /**
     * Removes an element with the specified key from this container.
     *
     * @param { K } key - Key of the target element.
     * @returns { V | undefined } Tthe value associated with the key if it was removed, undefined otherwise
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    remove(key: K): V | undefined;
    
    
    /**
     * Clears this container and sets its length to 0.
     *
     * @throws { BusinessError } 10200011 - The clear method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;
    
    
    /**
     * Obtains an iterator that contains all the keys in this container.
     *
     * @returns { IterableIterator<K> }
     * @throws { BusinessError } 10200011 - The keys method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    keys(): IterableIterator<K>;
    
    
    /**
     * Obtains an iterator that contains all the values in this container.
     *
     * @returns { IterableIterator<V> }
     * @throws { BusinessError } 10200011 - The values method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    values(): IterableIterator<V>;
    
    
    /**
     * Replaces an element in this container.
     *
     * @param { K } key - Key of the target element.
     * @param { V } newValue - New value of the element.
     * @returns { boolean } the boolean type(Is there a target pointed to by the key)
     * @throws { BusinessError } 10200011 - The replace method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    replace(key: K, newValue: V): boolean;
    /**
     * Uses a callback to traverse the elements in this container and obtain their position indexes.
     *
     * @param { HashMapCbFn<K, V> } callbackFn - Callback invoked to traverse the elements in the container.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackFn: HashMapCbFn<K, V>): void;
    
    
    /**
     * Obtains an iterator that contains all the elements in this container.
     *
     * @returns { IterableIterator<[K, V]> }
     * @throws { BusinessError } 10200011 - The entries method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    entries(): IterableIterator<[
        K,
        V
    ]>;
    /**
     * Obtains an iterator, each item of which is a JavaScript object.
     *
     * @returns { IterableIterator<[K, V]> } an iterator for the HashMap
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<[
        K,
        V
    ]>;
}
/**
 * The type of HashMap callback function.
 *
 * @typedef { function } HashMapCbFn
 * @param { V } value - The value of the current entry
 * @param { K } key - The key of the current entry
 * @param { HashMap<K, V> } map - The HashMap instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type HashMapCbFn<K, V> = (value: V, key: K, map: HashMap<K, V>) => void;
export default HashMap;
