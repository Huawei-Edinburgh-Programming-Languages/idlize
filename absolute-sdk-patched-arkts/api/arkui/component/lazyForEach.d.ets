/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit ArkUI
 * @arkts 1.2
 */

import { Builder } from './builder';
import { ComponentBuilder } from './../stateManagement/runtime';

/**
 * Defines type to operation data source.
 *
 * @enum { string }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export enum DataOperationType {
    /**
     * Add data.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ADD = 'add',
    /**
     * Delete data.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DELETE = 'delete',
    /**
     * Exchange data.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EXCHANGE = 'exchange',
    /**
     * Move data.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MOVE = 'move',
    /**
     * Change data.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CHANGE = 'change',
    /**
     * Reload data.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RELOAD = 'reload'
}

/**
 * Defines add operation.
 *
 * @interface DataAddOperation
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataAddOperation {
    /**
     * How to operate added data.
     *
     * @type { DataOperationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: DataOperationType;
    /**
     * Index of added data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number;
    /**
     * Count of added data in one operation
     * Only validate for ADD and DELETE.
     *
     * @type { ?number }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count?: number;
    /**
     * Key of added data.
     *
     * @type { ?(string | Array<string>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    key?: string | Array<string>;
}

/**
 * Defines delete operation.
 *
 * @interface DataDeleteOperation
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataDeleteOperation {
    /**
     * How to operate deleted data.
     *
     * @type { DataOperationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: DataOperationType;
    /**
     * Index of deleted data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number;
    /**
     * Count of deleted data in one operation
     * Only validate for ADD and DELETE.
     *
     * @type { ?number }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count?: number;
}

/**
 * Defines change operation.
 *
 * @interface DataChangeOperation
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataChangeOperation {
    /**
     * How to operate changed data.
     *
     * @type { DataOperationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: DataOperationType;
    /**
     * Index of changed data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number;
    /**
     * Key of changed data.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    key?: string;
}

/**
 * Defines position of moved data.
 *
 * @interface MoveIndex
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface MoveIndex {
    /**
     * Index of moved data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    from: number;
    /**
     * Destination of moved data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    to: number;
}

/**
 * Defines position of exchange data.
 *
 * @interface ExchangeIndex
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ExchangeIndex {
    /**
     * Index of the first exchange data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start: number;
    /**
     * Index of the second exchange data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    end: number;
}

/**
 * Defines new key of exchange data.
 *
 * @interface ExchangeKey
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ExchangeKey {
    /**
     * Key of the first exchange data.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start: string;
    /**
     * Key of the second exchange data.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    end: string;
}

/**
 * Defines move&exchange operation.
 *
 * @interface DataMoveOperation
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataMoveOperation {
    /**
     * How to operate moved data.
     *
     * @type { DataOperationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: DataOperationType;
    /**
     * Index of moved data.
     *
     * @type { MoveIndex }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: MoveIndex;
    /**
     * Key of moved data.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    key?: string;
}

/**
 * Defines exchange operation.
 *
 * @interface DataExchangeOperation
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataExchangeOperation {
    /**
     * How to operate exchange data.
     *
     * @type { DataOperationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: DataOperationType;
    /**
     * Index of exchange data.
     *
     * @type { ExchangeIndex }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: ExchangeIndex;
    /**
     * Key of exchange data.
     *
     * @type { ?ExchangeKey }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    key?: ExchangeKey;
}

/**
 * Defines reload operation.
 *
 * @interface DataReloadOperation
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataReloadOperation {
    /**
     * How to operate reload data.
     *
     * @type { DataOperationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: DataOperationType;
}

/**
 * All data operation type
 *
 * @typedef { DataAddOperation | DataDeleteOperation | DataChangeOperation | DataMoveOperation | DataExchangeOperation
 *  | DataReloadOperation }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type DataOperation = DataAddOperation | DataDeleteOperation | DataChangeOperation | DataMoveOperation |
    DataExchangeOperation | DataReloadOperation;

/**
 * Data Change Listener.
 *
 * @interface DataChangeListener
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface DataChangeListener {
    /**
     * Data ready.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDataReloaded(): void;
    /**
     * Data added.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDataAdd(index: number): void;
    /**
     * Data moved.
     *
     * @param { number } from
     * @param { number } to
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDataMove(from: number, to: number): void;
    /**
     * Data deleted.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDataDelete(index: number): void;
    /**
     * Call when has data change.
     *
     * @param { number } index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDataChange(index: number): void;
    /**
     * Call when multiple data change.
     *
     * @param { Array<DataOperation> } dataOperations
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDatasetChange(dataOperations: Array<DataOperation>): void;
}

/**
 * Developers need to implement this interface to provide data to LazyForEach component.
 *
 * @interface IDataSource
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface IDataSource<T> {
    /**
     * Total data count.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    totalCount(): number;
    /**
     * Return the data of index.
     *
     * @param { number } index
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getData(index: number): T;
    /**
     * Register data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    registerDataChangeListener(listener: DataChangeListener): void;
    /**
     * Unregister data change listener.
     *
     * @param { DataChangeListener } listener
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    unregisterDataChangeListener(listener: DataChangeListener): void;
}

/**
 * declare LazyForEachAttribute
 *
 * @interface LazyForEachAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface LazyForEachAttribute {}

/**
 * Define item generator function.
 *
 * @typedef { function } ItemGeneratorFunc<T>
 * @param { T } item - item in an array
 * @param { number } index - index corresponding to an array item.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Builder
declare type ItemGeneratorFunc<T> = (item: T, index: number) => void;

/**
 * Define key generator function.
 *
 * @typedef { function } KeyGeneratorFunc<T>
 * @param { T } item - item in an array
 * @param { number } index - index corresponding to an array item.
 * @returns {string} Character string generated based on item and index
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare type KeyGeneratorFunc<T> = (item: T, index: number) => string;

/**
 * Enter the value to obtain the LazyForEach.
 *
 * @param { IDataSource<T> } dataSource - the array collection to be used in UI
 * @param { ItemGeneratorFunc<T> } itemGenerator - item generator function
 * @param { KeyGeneratorFunc<T> } [keyGenerator] - key generator function
 * @returns { LazyForEachAttribute } LazyForEach attribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@ComponentBuilder
export declare function LazyForEach<T>(dataSource: IDataSource<T>,
    itemGenerator: ItemGeneratorFunc<T>,
    keyGenerator?: KeyGeneratorFunc<T>,
): LazyForEachAttribute;
