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

/**
 * MemoState is a mutable and remember state.
 *
 * @interface MemoState
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface MemoState<T> {
  /**
   * The current value of the memoized state.
   * @type { T }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly value: T;
}