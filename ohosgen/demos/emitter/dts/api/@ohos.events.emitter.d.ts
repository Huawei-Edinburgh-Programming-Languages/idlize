/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
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

declare namespace emitter {
  function emit(event: InnerEvent, data?: EventData): void;
  function emit(eventId: string, data?: EventData): void;
  function emit(eventId: string, options: Options, data?: EventData): void;

  export interface EventData {
    data?: { [key: string]: any };
  }

  export interface InnerEvent {
    eventId: number;
    priority?: EventPriority;
  }


  export enum EventPriority {
    IMMEDIATE = 0,

    HIGH,
    LOW,

    IDLE,
  }

  export interface Options {

    priority?: EventPriority;
  }
}

export default emitter;
