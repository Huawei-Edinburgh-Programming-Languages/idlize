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
 * LightWeightMap stores key-value (KV) pairs. Each key must be unique and have only one value.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class LightWeightMap<K, V> {
    
    
    /**
     * A constructor used to create a LightWeightMap object.
     *
     * @throws { BusinessError } 10200012 - The LightWeightMap's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
   * Gets the element number of the LightWeightMap.
   *
   * @type { int }
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
    get length(): int;
    
    
    /**
     * Returns whether this map has all the object in a specified map
     *
     * @param { LightWeightMap<K, V> } map - map map the Map object to compare
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 10200011 - The hasAll method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    hasAll(map: LightWeightMap<K, V>): boolean;
    
    
    /**
     * Returns whether a key is contained in this map
     *
     * @param { K } key - key key need to determine whether to include the key
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The hasKey method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    hasKey(key: K): boolean;
    
    
    /**
     * Returns whether a value is contained in this map
     *
     * @param { V } value - value value need to determine whether to include the value
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The hasValue method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    hasValue(value: V): boolean;
    
    
    /**
     * Ensures that the capacity of an LightWeightMap container is greater than or equal to a specified value,
     * and that the container has all the original objects after capacity expansion
     *
     * @param { int } minimumCapacity - minimumCapacity minimumCapacity Minimum capacity to be reserved
     * @throws { BusinessError } 10200011 - The increaseCapacityTo method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    increaseCapacityTo(minimumCapacity: int): void;
    
    
    /**
     * Returns a new Iterator object that contains the [key, value] pairs for each element in the Map object in insertion order
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
     * Returns the value to which the specified key is mapped, or undefined if this map contains no mapping for the key
     *
     * @param { K } key - key key the index in LightWeightMap
     * @returns { V | undefined } value if associated with key presents, undefined otherwise
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get(key: K): V | undefined;
    
    
    /**
     * Obtains the index of the key equal to a specified key in an LightWeightMap container
     *
     * @param { K } key - key key Looking for goals
     * @returns { int } Subscript corresponding to target
     * @throws { BusinessError } 10200011 - The getIndexOfKey method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOfKey(key: K): int;
    
    
    /**
     * Obtains the index of the value equal to a specified value in an LightWeightMap container
     *
     * @param { V } value - value value Looking for goals
     * @returns { int } Subscript corresponding to target
     * @throws { BusinessError } 10200011 - The getIndexOfValue method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOfValue(value: V): int;
    
    
    /**
     * Returns whether the Map object contains elements
     *
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The isEmpty method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;
    /**
     * Obtains the key at the location identified by index in an LightWeightMap container
     *
     * @param { int } index - index index Target subscript for search
     * @returns { K | undefined } the key of key-value pairs or undefined
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getKeyAt(index: int): K | undefined;
    
    
    /**
     * Obtains a ES6 iterator that contains all the keys of an LightWeightMap container
     *
     * @returns { IterableIterator<K> }
     * @throws { BusinessError } 10200011 - The keys method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    keys(): IterableIterator<K>;
    
    
    /**
     * Adds all element groups in one map to another map
     *
     * @param { LightWeightMap<K, V> } map - map map the Map object to add members
     * @throws { BusinessError } 10200011 - The setAll method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    setAll(map: LightWeightMap<K, V>): void;
    
    
    /**
     * Adds or updates a(new) key-value pair with a key and value specified for the Map object
     *
     * @param { K } key - key key Added or updated targets
     * @param { V } value - value  Added or updated value
     * @returns { Object } the map object after set
     * @throws { BusinessError } 10200011 - The set method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    set(key: K, value: V): Object;
    /**
     * Remove the mapping for this key from this map if present
     *
     * @param { K } key - key key Target to be deleted
     * @returns { V | undefined } the value associated with the key if it was removed, undefined otherwise
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    remove(key: K): V | undefined;
    
    
    /**
     * Deletes a key-value pair at the location identified by index from an LightWeightMap container
     *
     * @param { int } index - index index Target subscript for search
     * @returns { boolean } the boolean type(Is there a delete value)
     * @throws { BusinessError } 10200011 - The removeAt method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeAt(index: int): boolean;
    
    
    /**
     * Removes all of the mapping from this map
     * The map will be empty after this call returns
     *
     * @throws { BusinessError } 10200011 - The clear method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;
    
    
    /**
     * Sets the value identified by index in an LightWeightMap container to a specified value
     *
     * @param { int } index - index index Target subscript for search
     * @param { V } newValue - newValue value Updated the target mapped value
     * @returns { boolean } the boolean type(Is there a value corresponding to the subscript)
     * @throws { BusinessError } 10200011 - The setValueAt method cannot be bound.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    setValueAt(index: int, newValue: V): boolean;
    /**
     * Iterates over all key-value pairs in the LightWeightMap and executes a callback function for each entry.
     *
     * @param { LightWeightMapCbFn<K, V> } callbackFn - A callback function that will be executed for each key-value pair.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackFn: LightWeightMapCbFn<K, V>): void;
    /**
     * returns an ES6 iterator.Each item of the iterator is a Javascript Object
     *
     * @returns { IterableIterator<[K, V]> } an iterator for the LightWeightMap
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<[
        K,
        V
    ]>;
    
    
    /**
     * Obtains a string that contains all the keys and values in an LightWeightMap container
     *
     * @returns { String }
     * @throws { BusinessError } 10200011 - The toString method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    toString(): String;
    /**
       * Obtains the value identified by index in an LightWeightMap container
       *
       * @param { int } index - index index Target subscript for search
       * @returns { V | undefined } the value of key-value pairs or undefined
       * @throws { BusinessError } 10200001 - The value of index is out of range.
       * @syscap SystemCapability.Utils.Lang
       * @since 20
       */
    getValueAt(index: int): V | undefined;
    
    
    /**
     * Returns an iterator of the values contained in this map
     *
     * @returns { IterableIterator<V> }
     * @throws { BusinessError } 10200011 - The values method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    values(): IterableIterator<V>;
}
/**
 * The type of LightWeightMap callback function.
 *
 * @typedef { function } LightWeightMapCbFn
 * @param { V } value - The value of the current entry
 * @param { K } key - The key of the current entry
 * @param { LightWeightMap<K, V> } map - The LightWeightMap instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type LightWeightMapCbFn<K, V> = (value: V, key: K, map: LightWeightMap<K, V>) => void;
export default LightWeightMap;
