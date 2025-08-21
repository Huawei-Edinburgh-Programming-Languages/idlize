/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
 */
import { CommonMethod, } from './common';
import { Curve, AnimationStatus, FillMode, PlayMode } from "./enums";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Customize spring properties.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare class SpringProp {
    /**
     * Constructor parameters
     *
     * @param { number } mass
     * @param { number } stiffness
     * @param { number } damping
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    constructor(mass: number, stiffness: number, damping: number);
}
/**
 * Spring animation model. You can build a spring animation based on the start point, end point, initial speed, and spring attributes.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare class SpringMotion {
    /**
     * Constructor parameters
     *
     * @param { number } start
     * @param { number } end
     * @param { number } velocity
     * @param { SpringProp } prop
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    constructor(start: number, end: number, velocity: number, prop: SpringProp);
}
/**
 * Friction animation model. You can build friction animation by friction force, initial position, and initial velocity.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare class FrictionMotion {
    /**
     * Constructor parameters
     *
     * @param { number } friction
     * @param { number } position
     * @param { number } velocity
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    constructor(friction: number, position: number, velocity: number);
}
/**
 * Rolling animation model: You can build rolling animation based on the initial position, initial speed, boundary position, and spring attributes.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare class ScrollMotion {
    /**
     * Constructor parameters
     *
     * @param { number } position
     * @param { number } velocity
     * @param { number } min
     * @param { number } max
     * @param { SpringProp } prop
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    constructor(position: number, velocity: number, min: number, max: number, prop: SpringProp);
}
export declare interface AnimatorAttribute extends CommonMethod {
    /**
     * Controls the playback status. The default value is the initial state.
     *
     * @param { AnimationStatus } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    state(value: AnimationStatus | undefined): this;
    /**
     * Animation duration, in milliseconds.
     *
     * @param { number } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    duration(value: number | undefined): this;
    /**
     * Animation curve, default to linear curve
     *
     * @param { Curve } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    curve(value: Curve | undefined): this;
    /**
     * Delayed animation playback duration, in milliseconds. By default, the animation is not delayed.
     *
     * @param { number } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    delay(value: number | undefined): this;
    /**
     * Sets the state before and after the animation starts.
     *
     * @param { FillMode } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    fillMode(value: FillMode | undefined): this;
    /**
     * The default playback is once. If the value is -1, the playback is unlimited.
     *
     * @param { number } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    iterations(value: number | undefined): this;
    /**
     * Sets the animation playback mode. By default, the animation starts to play again after the playback is complete.
     *
     * @param { PlayMode } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    playMode(value: PlayMode | undefined): this;
    /**
     * Configure the physical animation algorithm.
     *
     * @param { SpringMotion | FrictionMotion | ScrollMotion } value
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    motion(value: SpringMotion | FrictionMotion | ScrollMotion | undefined): this;
    /**
     * Status callback, which is triggered when the animation starts to play.
     *
     * @param { function } event
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onStart(event: (() => void) | undefined): this;
    /**
     * Status callback, triggered when the animation pauses.
     *
     * @param { function } event
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onPause(event: (() => void) | undefined): this;
    /**
     * Status callback, triggered when the animation is replayed.
     *
     * @param { function } event
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onRepeat(event: (() => void) | undefined): this;
    /**
     * Status callback, which is triggered when the animation is canceled.
     *
     * @param { function } event
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onCancel(event: (() => void) | undefined): this;
    /**
     * Status callback, which is triggered when the animation playback is complete.
     *
     * @param { function } event
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onFinish(event: (() => void) | undefined): this;
    /**
     * The callback input parameter is the interpolation during animation playback.
     *
     * @param { function } event
     * @returns { AnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onFrame(event: ((value: number) => void) | undefined): this;
    attributeModifier(modifier: AttributeModifier<AnimatorAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Constructor parameters
 *
 * @param { string } value
 * @returns { AnimatorAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Animator(
    value: string, 
    @memo
    content_?: () => void,
): AnimatorAttribute