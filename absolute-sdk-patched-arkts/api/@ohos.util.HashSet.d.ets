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
 * HashSet is implemented based on HashMap. In HashSet, only the value object is processed.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class HashSet<T> {
    
    
    /**
     * A constructor used to create a HashSet object.
     *
     * @throws { BusinessError } 10200012 - The HashSet's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
   * Gets the element number of the HashSet.
   *
   * @type { int }
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
    get length(): int;
    
    
    /**
     * Returns whether the Set object contains elements
     *
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The isEmpty method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;
    
    
    /**
     * Returns whether the Set object contain s the elements
     *
     * @param { T } value - value value need to determine whether to include the element
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The has method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    has(value: T): boolean;
    
    
    /**
     * If the set does not contain the element, the specified element is added
     *
     * @param { T } value - value value Added element
     * @returns { boolean } the boolean type(Is there contain this element)
     * @throws { BusinessError } 10200011 - The add method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    add(value: T): boolean;
    
    
    /**
     * Remove a specified element from a Set object
     *
     * @param { T } value - value value Target to be deleted
     * @returns { boolean } the boolean type(Is there contain this element)
     * @throws { BusinessError } 10200011 - The remove method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    remove(value: T): boolean;
    
    
    /**
     * Clears all element groups in a set
     *
     * @throws { BusinessError } 10200011 - The clear method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;
    /**
     * Iterates over all elements in the HashSet and executes a callback function for each element.
     *
     * @param { HashSetCbFn<T> } callbackFn - A callback function to execute for each element.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackFn: HashSetCbFn<T>): void;
    
    
    /**
     * Returns a new Iterator object that contains the values contained in this set
     *
     * @returns { IterableIterator<T> }
     * @throws { BusinessError } 10200011 - The values method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    values(): IterableIterator<T>;
    
    
    /**
     * Returns a new Iterator object that contains the [key, value] pairs for each element in the Set object in insertion order
     *
     * @returns { IterableIterator<[T, T]> }
     * @throws { BusinessError } 10200011 - The entries method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    entries(): IterableIterator<[
        T,
        T
    ]>;
    /**
     * returns an iterator.Each item of the iterator is a Javascript Object
     *
     * @returns { IterableIterator<T> } an iterator for the HashSet
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<T>;
}
/**
 * The type of HashSet callback function.
 *
 * @typedef { function } HashSetCbFn
 * @param { T } value - The current element being processed
 * @param { T } key - [Deprecated] HashSet does not use key-value pairs, this parameter exists only for API compatibility
 * @param { HashSet<T> } set - The HashSet instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type HashSetCbFn<T> = (value: T, key: T, set: HashSet<T>) => void;
export default HashSet;
