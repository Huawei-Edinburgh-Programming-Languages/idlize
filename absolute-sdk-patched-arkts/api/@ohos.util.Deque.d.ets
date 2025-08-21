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
 * Double-ended queue (deque) is a sequence container implemented based on the queue data structure that
 * follows the principles of First In First Out (FIFO) and Last In First Out (LIFO).
 * It allows insertion and removal of elements at both the ends.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class Deque<T> {
    
    
    /**
     * A constructor used to create a Deque object.
     *
     * @throws { BusinessError } 10200012 - The Deque's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
   * Gets the element number of the Deque.
   *
   * @type { int }
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
    get length(): int;
    
    
    /**
     * Inserts an element into the deque header.
     *
     * @param { T } element - element element to be appended to this deque
     * @throws { BusinessError } 10200011 - The insertFront method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    insertFront(element: T): void;
    
    
    /**
     * Inserting an element at the end of a deque
     *
     * @param { T } element - element element to be appended to this deque
     * @throws { BusinessError } 10200011 - The insertEnd method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    insertEnd(element: T): void;
    
    
    /**
     * Check if deque contains the specified element
     *
     * @param { T } element - element element to be contained
     * @returns { boolean } the boolean type,if deque contains the specified element,return true,else return false
     * @throws { BusinessError } 10200011 - The has method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    has(element: T): boolean;
    /**
     * Obtains the header element of a deque.
     *
     * @returns { T | undefined } the first element of the deque if it exists, otherwise returns undefined.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getFirst(): T | undefined;
    /**
     * Obtains the end element of a deque.
     *
     * @returns { T | undefined } the last element of the deque if it exists, otherwise returns undefined.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getLast(): T | undefined;
    /**
     * Obtains the header element of a deque and delete the element.
     *
     * @returns { T | undefined } the deleted element of the deque if it exists, otherwise returns undefined.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    popFirst(): T | undefined;
    /**
     * Obtains the end element of a deque and delete the element.
     *
     * @returns { T | undefined } the deleted element of the deque if it exists, otherwise returns undefined.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    popLast(): T | undefined;
    /**
     * Iterates over elements in a generic Deque (double-ended queue) and executes a callback function for each element.
     *
     * @param { DequeForEachCb<T> } callbackFn - A callback function to execute for each element.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackFn: DequeForEachCb<T>): void;
    /**
    * Returns the item at that index.
    *
    * @param { int } index - The zero-based index of the desired code unit.
    *     Throws error if index < 0 or index >= deque.length.
    * @returns { T } The element in the deque matching the given index.
    * @throws { BusinessError } 10200001 - The value of index is out of range.
    * @syscap SystemCapability.Utils.Lang
    * @since 20
    */
    [index: int]: T;
    /**
     * Returns an iterator. Each item of the iterator is a ArkTS Object
     *
     * @returns { IterableIterator<T> }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<T>;
}
/**
 * The type of Deque forEach callback function.
 *
 * @typedef { function } DequeForEachCb
 * @param { T } value - The current element being processed
 * @param { int } index - The index of the current element
 * @param { Deque<T> } deque - The Deque instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type DequeForEachCb<T> = (value: T, index: int, deque: Deque<T>) => void;
export default Deque;
