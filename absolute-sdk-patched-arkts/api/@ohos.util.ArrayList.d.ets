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
 * ArrayList is a linear data structure that is implemented based on arrays.
 * ArrayList can dynamically adjust the capacity based on project requirements. It increases the capacity by 50% each time.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class ArrayList<T> {
    
    
    /**
     * A constructor used to create an ArrayList instance.
     *
     * @throws { BusinessError } 10200012 - The ArrayList's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
     * Gets the number of elements in an array list.
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
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @throws { BusinessError } 10200011 - The insert method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    insert(element: T, index: int): void;
    
    
    /**
     * Checks whether this container has the specified element.
     *
     * @param { T } element - Target element.
     * @returns { boolean } the boolean type,if arraylist contains the specified element,return true,else return false
     * @throws { BusinessError } 10200011 - The has method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    has(element: T): boolean;
    
    
    /**
     * Obtains the index of the first occurrence of the specified element in this container.
     *
     * @param { T } element - Target element.
     * @returns { int } the number type ,returns the lowest index such that or -1 if there is no such index.
     * @throws { BusinessError } 10200011 - The getIndexOf method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getIndexOf(element: T): int;
    
    
    /**
     * Removes an element with the specified position from this container.
     *
     * @param { int } index - Position index of the target element.
     * @returns { T } the T type ,returns undefined if arraylist is empty,If the index is
     * @throws { BusinessError } 10200001 - The value of "index" is out of range.
     * @throws { BusinessError } 10200011 - The removeByIndex method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeByIndex(index: int): T;
    
    
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
     * Removes from this container all of the elements within a range, including the element at the start position but
     * not that at the end position.
     *
     * @param { int } fromIndex - Index of the start position.
     * @param { int } toIndex - Index of the end position.
     * @throws { BusinessError } 10200001 - The value of fromIndex or toIndex is out of range.
     * @throws { BusinessError } 10200011 - The removeByRange method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    removeByRange(fromIndex: int, toIndex: int): void;
    /**
     * Replaces all elements in this container with new elements, and returns the new ones.
     *
     * @param { ArrayListReplaceCb<T> } callbackFn - Callback invoked for the replacement.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    replaceAllElements(callbackFn: ArrayListReplaceCb<T>): void;
    /**
     * Iterates over elements in a generic ArrayList and executes a callback function for each element.
     *
     * @param { ArrayListForEachCb<T> } callbackFn - A callback function to execute for each element.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackFn: ArrayListForEachCb<T>): void;
    
    
    
    /**
     * Sorts this arraylist according to the order induced by the specified comparator,without comparator this parameter,
     * it will default to ASCII sorting
     *
     * Anonymous Object Rectification
     * @param { ArrayListComparatorFn<T> } [comparator] - comparator
     * comparator (Optional) A function that accepts up to two arguments.Specifies the sort order.
     * Must be a function,return number type,If it returns firstValue minus secondValue, it returns an arraylist
     * sorted in ascending order;If it returns secondValue minus firstValue, it returns an arraylist sorted in descending order;
     * If this parameter is empty, it will default to ASCII sorting
     * @throws { BusinessError } 10200011 - The sort method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Incorrect parameter types;
     * 2.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    sort(comparator?: ArrayListComparatorFn<T>): void;
    
    
    /**
     * Obtains elements within a range in this container, including the element at the start position but not that at the
     * end position, and returns these elements as a new ArrayList instance.
     *
     * @param { int } fromIndex - Index of the start position.
     * @param { int } toIndex - Index of the end position.
     * @returns { ArrayList<T> }
     * @throws { BusinessError } 10200001 - The value of fromIndex or toIndex is out of range.
     * @throws { BusinessError } 10200011 - The subArrayList method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types;
     * 3.Parameter verification failed.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    subArrayList(fromIndex: int, toIndex: int): ArrayList<T>;
    
    
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
     * @returns { ArrayList<T> } this arraylist instance
     * @throws { BusinessError } 10200011 - The clone method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    clone(): ArrayList<T>;
    
    
    /**
     * Obtains the capacity of this container.
     *
     * @returns { int } the number type
     * @throws { BusinessError } 10200011 - The getCapacity method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getCapacity(): int;
    
    
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
     * Returns the element at the given index.
     *
     * @param { int } index - Index. The value must be less than or equal to int32_max, that is, 2147483647.
     * @returns { T } The element in the arraylist matching the given index.
     * @throws { BusinessError } 401 - Parameter error.
     * @throws { BusinessError } 10200001 - The value of index is out of range.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    [index: int]: T;
    
    
    /**
     * Increases the capacity of this container.
     *
     * @param { int } newCapacity - New capacity.
     * @throws { BusinessError } 10200011 - The increaseCapacityTo method cannot be bound.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * 1.Mandatory parameters are left unspecified;
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    increaseCapacityTo(newCapacity: int): void;
    
    
    /**
     * Releases the reserved space in this container by adjusting the container capacity to the actual number of elements
     * in this container.
     *
     * @throws { BusinessError } 10200011 - The trimToCurrentLength method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    trimToCurrentLength(): void;
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
 * @typedef { function } ArrayListComparatorFn
 * @param { T } firstValue - firstValue (required) previous element.
 * @param { T } secondValue - secondValue (required) next element.
 * @returns { double } the number type
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type ArrayListComparatorFn<T> = (firstValue: T, secondValue: T) => double;
/**
 * The type of ArrayList callback function.
 *
 * @typedef { function } ArrayListForEachCb
 * @param { T } value - The current element being processed
 * @param { int } index - The index of the current element
 * @param { ArrayList<T> } arrlist - The ArrayList instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type ArrayListForEachCb<T> = (value: T, index: int, arrlist: ArrayList<T>) => void;
/**
 * The type of ArrayList callback function.
 *
 * @typedef { function } ArrayListReplaceCb
 * @param { T } value - The current element being processed
 * @param { int } index - The index of the current element
 * @param { ArrayList<T> } arrlist - The ArrayList instance being traversed
 * @returns { T } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type ArrayListReplaceCb<T> = (value: T, index: int, arrlist: ArrayList<T>) => T;
export default ArrayList;
