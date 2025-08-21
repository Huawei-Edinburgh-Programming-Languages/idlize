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
 * List is implemented based on the singly linked list. Each node has a reference pointing to the next element.
 * When querying an element, the system traverses the list from the beginning. List offers efficient insertion
 * and removal operations but supports low query efficiency. List allows null elements.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class List<T> {
    
    
    /**
     * A constructor used to create a List instance.
     *
     * @throws { BusinessError } 10200012 - The List's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
     * Gets the element number of the List.
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
     *
     * @param { T } element - Target element.
     * @param { int } index - Index of the position where the element is to be inserted.
     * @throws { BusinessError } 10200011 - The insert method cannot be bound.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    insert(element: T, index: int): void;
    /**
     * Returns the element at the specified position in this list,
     * or returns undefined if this list is empty
     *
     * @param { int } index - specified position
     * @returns { T | undefined} the element at the specified index, or undefined if the index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get(index: int): T | undefined;
    
    
    /**
     * Checks whether this container has the specified element.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type,if list contains the specified element,return true,else return false
     * @throws { BusinessError } 10200011 - The has method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    has(element: T): boolean;
    
    
    /**
     * Obtains the index of the last occurrence of the specified element in this container.
     *
     * @param { T } element - Target element.
     * @returns { int } the int type ,returns the lowest index such that or -1 if there is no such index.
     * @throws { BusinessError } 10200011 - The getIndexOf method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOf(element: T): int;
    /**
     * Searches for an element based on its index and then removes it.
     *
     * @param { int } index - Position index of the target element.
     * @returns { T | undefined } the T type, if the index is
     * out of bounds (greater than or equal to length or less than 0), throw an exception
     * @throws { BusinessError } 10200001 - The value of "index" is out of range. It must be >= 0 && <= ${length - 1}.
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
     * Obtains the index of the last occurrence of the specified element in this container.
     *
     * @param { T } element - Target element.
     * @returns { int } the number type
     * @throws { BusinessError } 10200011 - The getLastIndexOf method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getLastIndexOf(element: T): int;
    /**
     * Obtains the first element in this container.
     *
     * @returns { T | undefined } the T type, returns undefined if list is empty
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getFirst(): T | undefined;
    /**
     * Obtains the last element in this container.
     *
     * @returns { T | undefined } the T type, returns undefined if list is empty
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getLast(): T | undefined;
    /**
     * Replaces an element at the specified position in this container with a given element.
     *
     * @param { int } index - Position index of the target element.
     * @param { T } element - Element to be used for replacement.
     * @returns { T | undefined } the T type, returns undefined if linkedList is empty
     * @throws { BusinessError } 10200001 - The value of "index" is out of range. It must be >= 0 && <= ${length - 1}.
     * Received value is: ${index}
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    set(index: int, element: T): T | undefined;
    
    
    /**
     * Compares whether a specified object is equal to this container.
     *
     * @param { Object } obj - Object used for comparison.
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The equal method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    equal(obj: Object): boolean;
    /**
     * Uses a callback to traverse the elements in this container and obtain their position indexes.
     *
     * @param { ListForEachCb } callbackFn - Callback invoked for the replacement.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackfn: ListForEachCb<T>): void;
    
    
    
    /**
     * Sorts this list according to the order induced by the specified comparator
     *
     * Anonymous Object Rectification
     * @param { ListComparatorFn<T> } comparator - comparator
     * comparator (required) A function that accepts up to two arguments.
     * Specifies the sort order. Must be a function,return number type,If it returns firstValue
     * minus secondValue, it returns an list sorted in ascending order;If it returns secondValue
     * minus firstValue, it returns an list sorted in descending order;
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 10200011 - The sort method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    sort(comparator: ListComparatorFn<T>): void;
    
    
    /**
     * Clears this container and sets its length to 0.
     *
     * @throws { BusinessError } 10200011 - The clear method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clear(): void;
    
    
    /**
     * Obtains elements within a range in this container, including the element at the start position but not that at the
     * end position, and returns these elements as a new List instance.
     *
     * @param { int } fromIndex - Index of the start position.
     * @param { int } toIndex - Index of the end position.
     * @returns { List<T> }
     * @throws { BusinessError } 10200011 - The getSubList method cannot be bound.
     * @throws { BusinessError } 10200001 - The value of fromIndex or toIndex is out of range.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getSubList(fromIndex: int, toIndex: int): List<T>;
    /**
     * Replaces all elements in this container with new elements, and returns the new ones.
     *
     * @param { ListReplaceCb } callbackFn - Callback invoked for the replacement.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    replaceAllElements(callbackfn: ListReplaceCb<T>): void;
    
    
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
     * Checks whether this container is empty (contains no element).
     *
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The isEmpty method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;
    /**
     * Returns the item at that index.
     *
     * @param { int } index - The zero-based index of the desired code unit.
     *     Throws error if index < 0 or index >= list.length.
     * @returns { T } The element in the list matching the given index.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    [index: int]: T;
    /**
     * Obtains an iterator, each item of which is a JavaScript object.
     *
     * @returns { IterableIterator<T> }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    $_iterator(): IterableIterator<T>;
}
/**
 * This type specifies the comparator of sort in comparation.
 *
 * @typedef { function } ListComparatorFn
 * @param { T } firstValue - firstValue (required) previous element.
 * @param { T } secondValue - secondValue (required) next element.
 * @returns { double } the number type
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type ListComparatorFn<T> = (firstValue: T, secondValue: T) => double;
/**
 * The type of List callback function.
 *
 * @typedef { function } ListForEachCb
 * @param { T } value - The value of current element
 * @param { int } index - The index of current element
 * @param { List<T> } list - The List instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type ListForEachCb<T> = (value: T, index: int, list: List<T>) => void;
/**
 * The type of List callback function.
 *
 * @typedef { function } LinkedListForEachCb
 * @param { T } value - The old value of current element
 * @param { int } index - The index of current element
 * @param { List<T> } list - The List instance being traversed
 * @returns { T } - The new value of current element
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type ListReplaceCb<T> = (value: T, index: int, list: List<T>) => T;
export default List;
