'use static'
/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */

import { LocalStorage } from '@ohos.arkui.stateManagement'
import { StateContext } from '../runtime-api/@koalaui.runtime.states.State'
export { MemoState } from './memorize/state'
// From incremental engine
@Retention({policy: "SOURCE"})
export declare @interface memo {};

@Retention({policy: "SOURCE"})
export @interface ComponentBuilder {}

export type __memo_context_type = StateContext;
export type __memo_id_type = MemoCallSiteKey;

export type MemoCallSiteKey = int;

export interface Disposable {
    readonly disposed: boolean;
    dispose(): void;
}

interface State<T> {
    readonly modified: boolean;
    readonly value: T;
}

export interface MutableState<T> extends Disposable, State<T> {
    value: T;
}

export type Equivalent<T> = (oldV: T, newV: T) => boolean;

export interface InternalScope<Value> {
    readonly unchanged: boolean;
    readonly cached: Value;
    recache(newValue?: Value): Value;
    param<T>(index: int, value: T, equivalent?: Equivalent<T>, name?: string, contextLocal?: boolean): State<T>;
}

// export interface StateContext {
//     scope<T>(id: MemoCallSiteKey, paramCount?: int): InternalScope<T>;
// }

// From Arkoala
export declare function propState<T>(value?: T): SyncedProperty<T>;
export declare function objectLinkState<T>(value?: T): SyncedProperty<T>;
export declare function stateOf<T>(value: T): MutableState<T>;
export declare function contextLocalStateOf<T>(value: string, key: () => T): MutableState<T>;
export declare function contextLocal<T>(value: string): MutableState<T>;
export declare function observableProxy<T>(value: T): T;
export declare function StorageLinkState<T>(storage: LocalStorage, name: string, value: T): MutableState<T>
export declare function AppStorageLinkState<T>(name: string, value: T): MutableState<T>;

export declare class SyncedProperty<T> implements MutableState<T> {
    constructor(value: T | undefined, deepCopyOnUpdate: boolean);
    dispose(): void;
    get disposed(): boolean;
    get modified(): boolean;
    get value(): T;
    set value(value: T);
    update(value?: T): void;
}
