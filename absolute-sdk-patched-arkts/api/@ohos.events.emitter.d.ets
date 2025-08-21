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
/**
 * @file
 * @kit BasicServicesKit
 */
import { Callback } from './@ohos.base';


/**
 * Provides methods for sending and processing in-process events.
 *
 * @namespace emitter
 * @syscap SystemCapability.Notification.Emitter
 * @since 20
 */
declare namespace emitter {
    
    
    /**
     * Subscribes to an event in persistent manner and executes a callback after the event is received.
     *
     * @param { InnerEvent } event - Event to subscribe to in persistent manner. The EventPriority parameter is not required and does not take effect.
     * @param { Callback<EventData> } callback - Callback to be executed when the event is received.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function on(event: InnerEvent, callback: Callback<EventData>): void;
    
    /**
     * Subscribes to an event in persistent manner and executes a callback after the event is received.
     *
     * @param { string } eventId - Event to subscribe to in persistent manner. The value cannot be an empty string and exceed 10240 bytes.
     * @param { Callback<EventData> } callback - Callback to be executed when the event is received.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function on(eventId: string, callback: Callback<EventData>): void;
    /**
     * Subscribe to a event by specific id in persistent manner and receives the event callback.
     *
     * @param { string } eventId - indicate ID of the event to subscribe to.
     * @param { Callback<EventData> | Callback<GenericEventData<T>> } callback - indicate callback used to receive the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function on<T>(eventId: string, callback: Callback<EventData> | Callback<GenericEventData<T>>): void;
    
    
    /**
     * Subscribes to an event in one-shot manner and unsubscribes from it after the event callback is executed.
     *
     * @param { InnerEvent } event - Event to subscribe to in one-shot manner. The EventPriority parameter is not required and does not take effect.
     * @param { Callback<EventData> } callback - Callback to be executed when the event is received.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function once(event: InnerEvent, callback: Callback<EventData>): void;
    
    /**
     * Subscribes to an event in one-shot manner and unsubscribes from it after the event callback is executed.
     *
     * @param { string } eventId - Event to subscribe to in one-shot manner. The value cannot be an empty string and exceed 10240 bytes.
     * @param { Callback<EventData> } callback - Callback to be executed when the event is received.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function once(eventId: string, callback: Callback<EventData>): void;
    
    
    /**
     * Unsubscribes from all events with the specified event ID.
     *
     * @param { long } eventId - Event ID.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function off(eventId: long): void;
    
    /**
     * Unsubscribes from all events with the specified event ID.
     *
     * @param { string } eventId - Event ID. The value cannot be an empty string and exceed 10240 bytes.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function off(eventId: string): void;
    
    
    /**
     * Unsubscribes from an event with the specified event ID and processed by the specified callback.
     *
     * @param { long } eventId - Event ID.
     * @param { Callback<EventData> } callback - Callback to unregister.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function off(eventId: long, callback: Callback<EventData>): void;
    
    /**
     * Unsubscribes from an event with the specified event ID and processed by the specified callback.
     *
     * @param { string } eventId - Event ID. The value cannot be an empty string and exceed 10240 bytes.
     * @param { Callback<EventData> } callback - Callback to unregister.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function off(eventId: string, callback: Callback<EventData>): void;
    /**
     * Unsubscribe specified callback function  from an event.
     *
     * @param { string } eventId - indicates ID of the event to unsubscribe from.
     * @param { Callback<EventData> | Callback<GenericEventData<T>> } callback - indicates callback used to receive the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function off<T>(eventId: string, callback: Callback<EventData> | Callback<GenericEventData<T>>): void;
    
    
    /**
     * Emits the specified event.
     *
     * @param { InnerEvent } event - Event to emit, where EventPriority specifies the emit priority of the event.
     * @param { EventData } [data] - Data passed in the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function emit(event: InnerEvent, data?: EventData): void;
    
    /**
     * Emits the specified event.
     *
     * @param { string } eventId - ID of the event to emit. The value cannot be an empty string and exceed 10240 bytes.
     * @param { EventData } [data] - Data passed in the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function emit(eventId: string, data?: EventData): void;
    /**
     * Emits the specified event.
     *
     * @param { string } eventId - ID of the event to emit. The value cannot be an empty string and exceed 10240 bytes.
     * @param { GenericEventData<T> } [data] - Data passed in the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function emit<T>(eventId: string, data?: GenericEventData<T>): void;
    /**
     * Emits an event by specific id to the event queue.
     *
     * @param { string } eventId - indicate ID of the event to emit.
     * @param { EventData | GenericEventData<T> } [data] - indicate data carried by the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function emit<T>(eventId: string, data?: EventData | GenericEventData<T>): void;
    
    /**
     * Emits an event of a specified priority.
     *
     * @param { string } eventId - ID of the event to emit. The value cannot be an empty string and exceed 10240 bytes.
     * @param { Options } options - Event emit priority.
     * @param { EventData } [data] - Data passed in the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function emit(eventId: string, options: Options, data?: EventData): void;
    /**
     * Emits an event of a specified priority.
     *
     * @param { string } eventId - ID of the event to emit. The value cannot be an empty string and exceed 10240 bytes.
     * @param { Options } options - Event emit priority.
     * @param { GenericEventData<T> } [data] - Data passed in the event.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function emit<T>(eventId: string, options: Options, data?: GenericEventData<T>): void;
    
    /**
     * Obtains the number of subscriptions to a specified event.
     *
     * @param { long | string } eventId - Event ID. The value of the string type cannot be an empty string.
     * @returns { long } Returns the number of listener count.
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    function getListenerCount(eventId: long | string): long;
    
    
    /**
     * Describes data passed in the event.
     *
     * @typedef EventData
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    export interface EventData {
        /**
         * Data carried by the event.
         *
         * @type { ?(Record<string, Object> | ESObject) }
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        data?: Record<string, Object> | ESObject;
    }
    
    
    /**
     * Describes an event to subscribe to or emit. The EventPriority settings do not take effect under event subscription.
     *
     * @typedef InnerEvent
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    export interface InnerEvent {
        
        
        /**
         * Event ID.
         *
         * @type { long }
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        eventId: long;
        
        
        /**
         * Event priority. The default value is EventPriority.LOW.
         *
         * @type { ?EventPriority }
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        priority?: EventPriority;
    }
    
    
    /**
     * Enumerates the event priorities.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    export enum EventPriority {
        
        
        /**
         * The event will be emitted immediately.
         *
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        IMMEDIATE = 0,
        
        
        /**
         * The event will be emitted before low-priority events.
         *
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        HIGH,
        
        
        /**
         * The event will be emitted before idle-priority events. By default, an event is in LOW priority.
         *
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        LOW,
        
        
        /**
         * The event will be emitted after all the other events.
         *
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        IDLE
    }
    
    /**
     * Describes the event emit priority.
     *
     * @typedef Options
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    export interface Options {
        
        /**
         * Event priority. The default value is EventPriority.LOW.
         *
         * @type { ?EventPriority }
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        priority?: EventPriority;
    }
    /**
     * Describes the generic data passed in the event.
     *
     * @typedef GenericEventData<T>
     * @syscap SystemCapability.Notification.Emitter
     * @since 20
     */
    export interface GenericEventData<T> {
        /**
         * Data carried by the event.
         *
         * @type { ?(T | ESObject) }
         * @syscap SystemCapability.Notification.Emitter
         * @since 20
         */
        data?: T | ESObject;
    }
}
export default emitter;
