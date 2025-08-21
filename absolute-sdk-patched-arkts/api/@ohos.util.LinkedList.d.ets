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
 * the system traverses the list from the beginning or end. LinkedList offers efficient insertion and
 * removal operations but supports low query efficiency. LinkedList allows null elements.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class LinkedList<T> {
    
    
    /**
     * A constructor used to create a LinkedList instance.
     *
     * @throws { BusinessError } 10200012 - The LinkedList's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
   * Gets the element number of the LinkedList.
   *
   * @type { int }
   * @syscap SystemCapability.Utils.Lang
   * @since 20
   */
    get length(): int;
    
    
    /**
     * Adds an element at the end of this container.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type, returns true if the addition is successful, and returns false if it fails.
     * @throws { BusinessError } 10200011 - The add method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    add(element: T): boolean;
    
    
    /**
     * Inserts an element at the specified position in this container.
     * @param { int } index - Index of the position where the element is to be inserted.
     * @param { T } element - Target element.
     * @throws { BusinessError } 10200011 - The insert method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    insert(index: int, element: T): void;
    /**
     * Obtains an element at the specified position in this container.
     *
     * @param { int } index - specified position
     * @returns { T | undefined} the element at the specified index, or undefined if the index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get(index: int): T | undefined;
    
    
    /**
     * Adds an element at the top of this container.
     *
     * @param { T } element - Target element.
     * @throws { BusinessError } 10200011 - The addFirst method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    addFirst(element: T): void;
    /**
     * Removes the first element from this container.
     *
     * @returns { T | undefined } the head of this list
     * @throws { BusinessError } 10200010 - Container is empty.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeFirst(): T | undefined;
    /**
     * Removes and returns the last element from this linkedList.
     *
     * @returns { T | undefined } the head of this list
     * @throws { BusinessError } 10200010 - Container is empty.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeLast(): T | undefined;
    
    
    /**
     * Checks whether this container has the specified element.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type,if linkedList contains the specified element,return true,else return false
     * @throws { BusinessError } 10200011 - The has method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    has(element: T): boolean;
    
    
    /**
     * Obtains the index of the first occurrence of the specified element in this container.
     *
     * @param { T } element - Target element.
     * @returns { int } the int type ,returns the lowest index such that or -1 if there is no such index.
     * @throws { BusinessError } 10200011 - The getIndexOf method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOf(element: T): int;
    /**
     * Find the corresponding element according to the index.
     *
     * @param { int } index - the index in the linkedList
     * @returns { T | undefined } the T type, if the index is
     * out of bounds (greater than or equal to length or less than 0), throw an exception
     * @throws { BusinessError } 10200001 - The value of "index" is out of range. It must be >= 0 && <= ${length}.
     * Received value is: ${index}
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeByIndex(index: int): T | undefined;
    
    
    /**
     * Removes the first occurrence of the specified element from this container.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type ,If there is no such element, return false
     * @throws { BusinessError } 10200011 - The remove method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    remove(element: T): boolean;
    
    
    /**
     * Removes the first occurrence of the specified element from this container.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type ,If there is no such element, return false
     * @throws { BusinessError } 10200011 - The removeFirstFound method cannot be bound.
     * @throws { BusinessError } 10200010 - Container is empty.
     * @throws { BusinessError } 10200017 - The element does not exist in this container.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeFirstFound(element: T): boolean;
    
    
    /**
     * Removes the last occurrence of the specified element from this container.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type ,If there is no such element, return false
     * @throws { BusinessError } 10200011 - The removeLastFound method cannot be bound.
     * @throws { BusinessError } 10200010 - Container is empty.
     * @throws { BusinessError } 10200017 - The element does not exist in this container.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeLastFound(element: T): boolean;
    
    
    /**
     * Obtains the index of the last occurrence of the specified element in this container.
     *
     * @param { T } element - Target element.
     * @returns { int } the int type
     * @throws { BusinessError } 10200011 - The getLastIndexOf method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getLastIndexOf(element: T): int;
    /**
     * Obtains the first element in this container.
     *
     * @returns { T | undefined } the T type, returns undefined if linkedList is empty
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getFirst(): T | undefined;
    /**
     * Obtains the last element in this container.
     *
     * @returns { T | undefined } the T type, returns undefined if linkedList is empty
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getLast(): T | undefined;
    /**
     * Replaces an element at the specified position in this container with a given element.
     *
     * @param { int } index - Position index of the target element.
     * @param { T } element - Element to be used for replacement.
     * @returns { T | undefined } the T type ,returns undefined if linkedList is empty
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    set(index: int, element: T): T | undefined;
    /**
     * Uses a callback to traverse the elements in this container and obtain their position indexes.
     *
     * @param { LinkedListForEachCb } callbackFn - Callback invoked to traverse the elements in the container.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackfn: LinkedListForEachCb<T>): void;
    
    
    /**
     * Clears this container and sets its length to 0.
     *
     * @throws { BusinessError } 10200011 - The clear method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;
    
    
    /**
     * Clones this container and returns a copy. The modification to the copy does not affect the original instance.
     *
     * @returns { LinkedList<T> } this linkedlist instance
     * @throws { BusinessError } 10200011 - The clone method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clone(): LinkedList<T>;
    
    
    /**
     * Converts this container into an array.
     *
     * @returns { Array<T> } the Array type
     * @throws { BusinessError } 10200011 - The convertToArray method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    convertToArray(): Array<T>;
    /**
     * returns an iterator. Each item of the iterator is a ArkTS Object
     *
     * @returns { IterableIterator<T> }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<T>;
}
/**
 * The type of LinkedList callback function.
 *
 * @typedef { function } LinkedListForEachCb
 * @param { T } value - The value of current element
 * @param { int } index - The index of current element
 * @param { LinkedList<T> } linkedList - The LinkedList instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type LinkedListForEachCb<T> = (value: T, index: int, linkedList: LinkedList<T>) => void;
export default LinkedList;
