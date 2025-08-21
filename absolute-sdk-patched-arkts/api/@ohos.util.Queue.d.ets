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
 * Queue follows the principle of First In First Out (FIFO).
 * It supports insertion of elements at the end and removal from the front of the queue.
 * Queue is implemented based on the queue data structure.
 *
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
declare class Queue<T> {
    
    
    /**
     * A constructor used to create a Queue object.
     *
     * @throws { BusinessError } 10200012 - The Queue's constructor cannot be directly invoked.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    constructor();
    /**
     * Gets the element number of the Queue.
     *
     * @type { int }
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    get length(): int;
    
    
    /**
     * Inserting specified element at the end of a queue if it is possible to do
     * so immediately without violating capacity restrictions.
     *
     * @param { T } element - element element to be appended to this queue
     * @returns { boolean } the boolean type
     * @throws { BusinessError } 10200011 - The add method cannot be bound.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    add(element: T): boolean;
    /**
     * Obtains the header element of a queue.
     *
     * @returns { T | undefined } the first element of the queue if it exists, otherwise returns undefined.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    getFirst(): T | undefined;
    /**
     * Retrieves and removes the head of this queue
     *
     * @returns { T | undefined } the deleted element of the deque if it exists, otherwise returns undefined.
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    pop(): T | undefined;
    /**
     * Executes a provided function once for each value in the queue object.
     *
     * @param { QueueForEachCb } callbackFn - callbackFn
     * @syscap SystemCapability.Utils.Lang
     * @since 20
     */
    forEach(callbackfn: QueueForEachCb<T>): void;
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
 * The type of Queue callback function.
 *
 * @typedef { function } QueueForEachCb
 * @param { T } value - The value of current element
 * @param { int } index - The key of current element
 * @param { Queue<T> } queue - The Queue instance being traversed
 * @returns { void } This callback does not return a value
 * @syscap SystemCapability.Utils.Lang
 * @since 20
 */
export type QueueForEachCb<T> = (value: T, index: int, queue: Queue<T>) => void;
export default Queue;
