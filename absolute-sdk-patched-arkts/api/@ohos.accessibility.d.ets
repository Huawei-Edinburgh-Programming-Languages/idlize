/*
 * Copyright (C) 2021-2025 Huawei Device Co., Ltd.
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
 * @kit AccessibilityKit
 */
import type { AsyncCallback } from './@ohos.base';
import type { Callback } from './@ohos.base';
import { Resource } from './global/resource';


/**
 * Accessibility
 *
 * @namespace accessibility
 * @syscap SystemCapability.BarrierFree.Accessibility.Core
 * @since 20
 */
declare namespace accessibility {
    
    /**
     * The action that the ability can execute.
     * value range: { 'accessibilityFocus' | 'clearAccessibilityFocus' | 'focus' | 'clearFocus' | 'clearSelection' |
     * 'click' | 'longClick' | 'cut' | 'copy' | 'paste' | 'select' | 'setText' | 'delete' |
     * 'scrollForward' | 'scrollBackward' | 'setSelection' | 'setCursorPosition' | 'home' |
     * 'back' | 'recentTask' | 'notificationCenter' | 'controlCenter' | 'common' }
     *
     * @typedef {'accessibilityFocus' | 'clearAccessibilityFocus' | 'focus' | 'clearFocus' | 'clearSelection' | 'click' | 'longClick' | 'cut' | 'copy' | 'paste' | 'select' | 'setText' | 'delete' | 'scrollForward' | 'scrollBackward' | 'setSelection' | 'setCursorPosition' | 'home' | 'back' | 'recentTask' | 'notificationCenter' | 'controlCenter' | 'common'}
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    type Action = 'accessibilityFocus' | 'clearAccessibilityFocus' | 'focus' | 'clearFocus' | 'clearSelection' | 'click' | 'longClick' | 'cut' | 'copy' | 'paste' | 'select' | 'setText' | 'delete' | 'scrollForward' | 'scrollBackward' | 'setSelection' | 'setCursorPosition' | 'home' | 'back' | 'recentTask' | 'notificationCenter' | 'controlCenter' | 'common';
    
    
    /**
     * The type of the accessibility event.
     * windowsChange/windowContentChange/windowStateChange/announcement/notificationChange/textTraversedAtMove
     * value range: { 'accessibilityFocus' | 'accessibilityFocusClear' |
     * 'click' | 'longClick' | 'focus' | 'select' | 'hoverEnter' | 'hoverExit' |
     * 'textUpdate' | 'textSelectionUpdate' | 'scroll' | 'requestFocusForAccessibility' |
     * 'announceForAccessibility' | 'requestFocusForAccessibilityNotInterrupt' |
     * 'announceForAccessibilityNotInterrupt' | 'scrolling' }
     *
     * @typedef {'accessibilityFocus' | 'accessibilityFocusClear' | 'click' | 'longClick' | 'focus' | 'select' | 'hoverEnter' | 'hoverExit' | 'textUpdate' | 'textSelectionUpdate' | 'scroll' | 'requestFocusForAccessibility' | 'announceForAccessibility' | 'requestFocusForAccessibilityNotInterrupt' | 'announceForAccessibilityNotInterrupt' | 'scrolling'}
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    type EventType = 'accessibilityFocus' | 'accessibilityFocusClear' | 'click' | 'longClick' | 'focus' | 'select' | 'hoverEnter' | 'hoverExit' | 'textUpdate' | 'textSelectionUpdate' | 'scroll' | 'requestFocusForAccessibility' | 'announceForAccessibility' | 'requestFocusForAccessibilityNotInterrupt' | 'announceForAccessibilityNotInterrupt' | 'scrolling';
    /**
     * The change type of the windowsChange event.
     * It's used when received the {@code windowsChange} event.
     *
     * @typedef {'add' | 'remove' | 'bounds' | 'active' | 'focus'}
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    type WindowUpdateType = 'add' | 'remove' | 'bounds' | 'active' | 'focus';
    /**
     * The granularity of text move.
     *
     * @typedef {'char' | 'word' | 'line' | 'page' | 'paragraph'}
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    type TextMoveUnit = 'char' | 'word' | 'line' | 'page' | 'paragraph';
    
    
    /**
     * Checks whether accessibility ability is enabled.
     *
     * @returns { boolean } Returns true if the accessibility is enabled; returns false otherwise.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function isOpenAccessibilitySync(): boolean;
    
    /**
     * Checks touch browser ability (which is used by talkback) is enabled.
     *
     * @returns { boolean } Returns true if the touch browser is enabled; returns false otherwise.
     * @syscap SystemCapability.BarrierFree.Accessibility.Vision
     * @since 20
     */
    function isOpenTouchGuideSync(): boolean;
    /**
     * Send accessibility event.
     *
     * @param { EventInfo } event The object of the accessibility {@code EventInfo} .
     * @param { AsyncCallback<void> } callback Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function sendAccessibilityEventWithCallback(event: EventInfo, callback: AsyncCallback<void>): void;
    /**
     * Send accessibility event.
     *
     * @param { EventInfo } event The object of the accessibility {@code EventInfo} .
     * @returns { Promise<void> } Returns {@code true} if success ; returns {@code false} otherwise.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function sendAccessibilityEventReturnsPromise(event: EventInfo): Promise<void>;
    /**
     */
    overload sendAccessibilityEvent {
        sendAccessibilityEventWithCallback,
        sendAccessibilityEventReturnsPromise
    };
    /**
     * Register the observe of the accessibility state changed.
     *
     * @param { 'accessibilityStateChange' } type state event type.
     * @param { Callback<boolean> } callback Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function onAccessibilityStateChange(type: 'accessibilityStateChange', callback: Callback<boolean>): void;
    /**
     * Register the observe of the touchGuide state changed.
     *
     * @param { 'touchGuideStateChange' } type state event type.
     * @param { Callback<boolean> } callback Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Vision
     * @since 20
     */
    function onTouchGuideStateChange(type: 'touchGuideStateChange', callback: Callback<boolean>): void;
    /**
     * Register the observe of the screen reader state changed.
     * @param { 'screenReaderStateChange' } type state event type.
     * @param { Callback<boolean> } callback callback Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function onScreenReaderStateChange(type: 'screenReaderStateChange', callback: Callback<boolean>): void;
    /**
     */
    overload on {
        onAccessibilityStateChange,
        onTouchGuideStateChange,
        onScreenReaderStateChange
    };
    /**
     * Unregister the observe of the accessibility state changed.
     *
     * @param { 'accessibilityStateChange' } type state event type
     * @param { Callback<boolean> } [callback] Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function offAccessibilityStateChange(type: 'accessibilityStateChange', callback?: Callback<boolean>): void;
    /**
     * Unregister the observe of the touchGuide state changed.
     *
     * @param { 'touchGuideStateChange' } type state event type
     * @param { Callback<boolean> } [callback] Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function offTouchGuideStateChange(type: 'touchGuideStateChange', callback?: Callback<boolean>): void;
    /**
     * Unregister the observe of the screen reader state changed.
     * @param { 'screenReaderStateChange' } type state event type
     * @param { Callback<boolean> } [callback] callback Asynchronous callback interface.
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    function offScreenReaderStateChange(type: 'screenReaderStateChange', callback?: Callback<boolean>): void;
    /**
     */
    overload off {
        offAccessibilityStateChange,
        offTouchGuideStateChange,
        offScreenReaderStateChange
    };
    /**
     * Indicates the info of events.
     *
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @since 20
     */
    class EventInfo {
        /**
         * A constructor used to create a EventInfo object.
         *
         * @param { EventType } type - The type of the accessibility event.
         * @param { string } bundleName - The name of the bundle.
         * @param { Action } triggerAction - The action that the ability can execute.
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        constructor(type: EventType, bundleName: string, triggerAction: Action);
        /**
         * The type of an accessibility event.
         * @type { EventType }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        type: EventType;
        /**
         * The type of the window change event.
         * @type { ?WindowUpdateType }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        windowUpdateType?: WindowUpdateType;
        /**
         * The bundle name of the target application.
         * @type { string }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        bundleName: string;
        /**
         * The type of the event source component,such as button, chart.
         * @type { ?string }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        componentType?: string;
        /**
         * The accessibility event description.
         * @type { ?string }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        description?: string;
        /**
         * The action that triggers the accessibility event, for example, clicking or focusing a view.
         * @type { Action }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        triggerAction: Action;
        /**
         * The movement step used for reading texts.
         * @type { ?TextMoveUnit }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        textMoveUnit?: TextMoveUnit;
        /**
         * The content list.
         * @type { ?Array<string> }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        contents?: Array<string>;
        /**
         * The content changed before.
         * @type { ?string }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        lastContent?: string;
        /**
         * The content of announce accessibility text.
         * @type { ?string }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        textAnnouncedForAccessibility?: string;
        /**
         * The customized element id.
         * @type { ?string }
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @since 20
         */
        customId?: string;
    }
}
export default accessibility;
