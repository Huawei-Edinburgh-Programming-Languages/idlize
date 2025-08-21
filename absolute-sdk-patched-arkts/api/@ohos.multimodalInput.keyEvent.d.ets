/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
 * @kit InputKit
 */
import type { InputEvent } from './@ohos.multimodalInput.inputEvent';
import type { KeyCode } from './@ohos.multimodalInput.keyCode';

/**
 * Action
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum Action {
    
    /**
     * Cancel key
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    CANCEL = 0,
    
    /**
     * Down key
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    DOWN = 1,
    
    /**
     * Up key
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    UP = 2
}

/**
 * Key
 *
 * @typedef Key
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare interface Key {
    
    /**
     * Key code
     * @type { KeyCode }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    code: KeyCode;
    
    /**
     * Time when the key is pressed
     * @type { long }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    pressedTime: long;
    
    /**
     * Device to which the key belongs
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    deviceId: int;
}

/**
 * KeyEvent
 *
 * @typedef KeyEvent
 * @extends InputEvent
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare interface KeyEvent extends InputEvent {
    
    /**
     * Key action
     * @type { Action }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    action: Action;
    
    /**
     * Key that has changed
     * @type { Key }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    key: Key;
    
    /**
     * Unicode character corresponding to the key
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    unicodeChar: int;
    
    /**
     * List of pressed keys
     * @type { Key[] }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    keys: Key[];
    
    /**
     * Whether ctrlKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    ctrlKey: boolean;
    
    /**
     * Whether altKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    altKey: boolean;
    
    /**
     * Whether shiftKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    shiftKey: boolean;
    
    /**
     * Whether logoKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    logoKey: boolean;
    
    /**
     * Whether fnKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    fnKey: boolean;
    
    /**
     * Whether capsLock is active
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    capsLock: boolean;
    
    /**
     * Whether numLock is active
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    numLock: boolean;
    
    /**
     * Whether scrollLock is active
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    scrollLock: boolean;
}
