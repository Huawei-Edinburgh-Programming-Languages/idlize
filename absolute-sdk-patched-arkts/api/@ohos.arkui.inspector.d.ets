/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { Callback } from './@ohos.base';

/**
 * Used to do observer layout and draw event for component.
 *
 * @namespace inspector
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace inspector {
    
    /**
     * The ComponentObserver is used to listen for layout, draw and drawChildren events.
     *
     * @interface ComponentObserver
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    interface ComponentObserver {
        
        /**
         * Registers a callback with the corresponding query condition by using the handle.
         * This callback is triggered when the component layout complete.
         * @param { 'layout' } type - type of the listened event.
         * @param { Callback<void> } callback - callback of the listened event.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        onLayout(type: 'layout', callback: Callback<void>): void;
        
        /**
         * Deregisters a callback with the corresponding query condition by using the handle.
         * This callback is not triggered when the component layout complete.
         * @param { 'layout' } type - type of the listened event.
         * @param { Callback<void> } [callback] - callback of the listened event.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        offLayout(type: 'layout', callback?: Callback<void>): void;
        
        /**
         * Registers a callback with the corresponding query condition by using the handle.
         * This callback is triggered when the component draw complete.
         * @param { 'draw' } type - type of the listened event.
         * @param { Callback<void> } callback - callback of the listened event.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        onDraw(type: 'draw', callback: Callback<void>): void;
        
        /**
         * Deregisters a callback with the corresponding query condition by using the handle.
         * This callback is not triggered when the component draw complete.
         * @param { 'draw' } type - type of the listened event.
         * @param { Callback<void> } [callback] - callback of the listened event.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        offDraw(type: 'draw', callback?: Callback<void>): void;

        /**
         * Registers a callback with the corresponding query condition by using the handle.
         * This callback is triggered when the child of component draw complete.
         * @param { 'drawChildren' } type - type of the listened event.
         * @param { Callback<void> } callback - callback of the listened event.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        onDrawChildren(type: 'drawChildren', callback: Callback<void>): void;

        /**
         * Deregisters a callback with the corresponding query condition by using the handle.
         * This callback is not triggered when the child of component draw complete.
         * @param { 'drawChildren' } type - type of the listened event.
         * @param { Callback<void> } [callback] - callback of the listened event.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        offDrawChildren(type: 'drawChildren', callback?: Callback<void>): void;

        /**
         * @since 20
         */
        overload on { onLayout, onDraw, onDrawChildren }
        /**
         * @since 20
         */
        overload off { offLayout, offDraw, offDrawChildren }
    }
    
    /**
     * Sets the component after layout or draw criteria and returns the corresponding listening handle
     * @param { string } id - component id.
     * @returns { ComponentObserver } create listener for observer component event.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     * @deprecated since 18
     * @useinstead ohos.arkui.UIContext.UIInspector#createComponentObserver
     */
    function createComponentObserver(id: string): ComponentObserver;
    /**
     * Obtains all attributes of the component with the specified ID.
     *
     * @param { string } id - ID of the component whose attributes are to be obtained.
     * @returns { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     * @test
     */
    function getInspectorByKey(id: string): string;
    /**
     * Get components tree.
     *
     * @returns { Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     * @test
     */
    function getInspectorTree(): Object;
    /**
     * Sends an event to the component with the specified ID.
     *
     * @param { string } id - ID of the component for which the event is to be sent.
     * @param { int } action - Type of the event to be sent. The options are as follows: Click event: 10 LongClick: 11.
     * @param { string } params - Event parameters. If there is no parameter, pass an empty string "".
     * @returns { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     * @test
     */
    function sendEventByKey(id: string, action: int, params: string): boolean;
}
export default inspector;
/**
 * export function getInspectorByKey from inspector namespace and provide it for kit ArkUI.
 * @constant
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export const GETINSPECTORBYKEY = inspector.getInspectorByKey;
/**
 * export function getInspectorTree from inspector namespace and provide it for kit ArkUI.
 * @constant
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export const GETINSPECTORTREE = inspector.getInspectorTree;
/**
 * export function sendEventByKey from inspector namespace and provide it for kit ArkUI.
 * @constant
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export const SENDEVENTBYKEY = inspector.sendEventByKey;
