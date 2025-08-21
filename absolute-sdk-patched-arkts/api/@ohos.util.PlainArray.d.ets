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
 * PlainArray stores key-value (KV) pairs. Each key must be unique, be of the number type, and have only one value.
 * PlainArray is based on generics and uses a lightweight structure.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class PlainArray<T> {
    
    
    /**
     * A constructor used to create a PlainArray object.
     *
     * @throws { BusinessError } 10200012 - The PlainArray's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
     * Gets the element number of the PlainArray.
     *
     * @type { int }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get length(): int;
    
    
    /**
     * Appends a key-value pair to PlainArray
     *
     * @param { int } key - key key Added the key of key-value
     * @param { T } value - value value Added the value of key-value
     * @throws { BusinessError } 10200011 - The add method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    add(key: int, value: T): void;
    
    
    /**
     * Clears the current PlainArray object
     *
     * @throws { BusinessError } 10200011 - The clear method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;
    
    
    /**
     * Obtains a clone of the current PlainArray object
     *
     * @returns { PlainArray<T> }
     * @throws { BusinessError } 10200011 - The clone method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clone(): PlainArray<T>;
    
    
    /**
     * Checks whether the current PlainArray object contains the specified key
     *
     * @param { int } key - key key need to determine whether to include the key
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The has method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    has(key: int): boolean;
    /**
     * Queries the value associated with the specified key
     *
     * @param { int } key - looking for goals
     * @returns { T | undefined } the value of key-value pairs
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get(key: int): T | undefined;
    
    
    /**
     * Queries the index for a specified key
     *
     * @param { int } key - key key Looking for goals
     * @returns { int } Subscript corresponding to target
     * @throws { BusinessError } 10200011 - The getIndexOfKey method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOfKey(key: int): int;
    
    
    /**
     * Queries the index for a specified value
     *
     * @param { T } value - value value Looking for goals
     * @returns { int } Subscript corresponding to target
     * @throws { BusinessError } 10200011 - The getIndexOfValue method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOfValue(value: T): int;
    
    
    /**
     * Checks whether the current PlainArray object is empty
     *
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The isEmpty method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;
    
    
    /**
     * Queries the key at a specified index
     *
     * @param { number } index - index index Target subscript for search
     * @returns { number } the key of key-value pairs
     * @throws { BusinessError } 10200011 - The getKeyAt method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getKeyAt(index: number): number;
    /**
     * Remove the key-value pair based on a specified key if it exists and return the value
     *
     * @param { int } key - target to be deleted
     * @returns { T | undefined } target mapped value, or undefined if key is not exist
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    remove(key: int): T | undefined;
    /**
     * Remove the key-value pair at a specified index if it exists and return the value
     *
     * @param { int } index - target subscript for search
     * @returns { T | undefined } the T type, or undefined if container is empty
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeAt(index: int): T | undefined;
    
    
    /**
     * Remove a group of key-value pairs from a specified index
     *
     * @param { int } index - index index remove start index
     * @param { int } size - size size Expected deletion quantity
     * @returns { int } Actual deleted quantity
     * @throws { BusinessError } 10200011 - The removeRangeFrom method cannot be bound.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeRangeFrom(index: int, size: int): int;
    
    
    /**
     * Update value on specified index
     *
     * @param { int } index - index index Target subscript for search
     * @param { T } value - value value Updated the target mapped value
     * @throws { BusinessError } 10200011 - The setValueAt method cannot be bound.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    setValueAt(index: int, value: T): void;
    
    
    /**
     * Obtains the string representation of the PlainArray object
     *
     * @returns { String }
     * @throws { BusinessError } 10200011 - The toString method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    toString(): String;
    
    
    /**
     * Queries the value at a specified index
     *
     * @param { int } index - index index Target subscript for search
     * @returns { T } the value of key-value pairs
     * @throws { BusinessError } 10200011 - The getValueAt method cannot be bound.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getValueAt(index: int): T;
    /**
     * Executes a provided function once for each value in the PlainArray object.
     *
     * @param { PlainArrayForEachCb<T> } callbackFn - callbackFn
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackFn: PlainArrayForEachCb<T>): void;
    /**
     * returns an iterator. Each item of the iterator is a ArkTS Object
     *
     * @returns { IterableIterator<[int, T]> }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<[
        int,
        T
    ]>;
}
/**
 * The type of PlainArray callback function.
 *
 * @typedef { function } PlainArrayForEachCb
 * @param { T } value - The value of current element
 * @param { int } key - The key of current element
 * @param { PlainArray<T> } PlainArray - The PlainArray instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type PlainArrayForEachCb<T> = (value: T, key: int, PlainArray: PlainArray<T>) => void;
export default PlainArray;
