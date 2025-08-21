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
 * Stack is implemented based on the array data structure.
 * It follows the principle Last Out First In (LOFI) and supports data insertion and removal at one end.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class Stack<T> {
    
    
    /**
     * A constructor used to create a Stack object.
     *
     * @throws { BusinessError } 10200012 - The Stack's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
     * Gets the element number of the Stack.
     *
     * @type { int }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get length(): int;
    
    
    /**
     * Tests if this stack is empty
     *
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The isEmpty method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    isEmpty(): boolean;
    /**
     * Looks at the object at the top of this stack without removing it from the stack
     * Return undefined if this stack is empty
     *
     * @returns { T | undefined } the top value, or undefined if container is empty
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    peek(): T | undefined;
    /**
     * Removes the object at the top of this stack and returns that object as the value of this function
     * an exception if the stack is empty
     *
     * @returns { T | undefined } Stack top value, or undefined if container is empty
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    pop(): T | undefined;
    
    
    /**
     * Pushes an item onto the top of this stack
     *
     * @param { T } item - item item to be appended to this Stack
     * @returns { T } the T type
     * @throws { BusinessError } 10200011 - The push method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    push(item: T): T;
    
    
    /**
     * Returns the 1-based position where an object is on this stack
     *
     * @param { T } element - element element Target to be deleted
     * @returns { int } the T type,If there is no such element, return -1
     * @throws { BusinessError } 10200011 - The locate method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    locate(element: T): int;
    /**
     * Executes a provided function once for each value in the Stack object.
     *
     * @param { StackForEachCb } callbackFn - callbackFn
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackfn: StackForEachCb<T>): void;
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
 * The type of Stack callback function.
 *
 * @typedef { function } StackForEachCb
 * @param { T } value - The value of current element
 * @param { int } index - The key of current element
 * @param { Stack<T> } stack - The Stack instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type StackForEachCb<T> = (value: T, index: int, stack: Stack<T>) => void;
export default Stack;
