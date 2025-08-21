'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
 * Contains interpolator functions such as initialization, third-order Bezier curves, and spring curves.
 *
 * @namespace curves
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace curves {

    /**
     * enum Curve.
     *
     * @enum { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export enum Curve {

        /**
         * Linear. Indicates that the animation has the same velocity from start to finish.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        Linear,

        /**
         * Ease. Indicates that the animation starts at a low speed, then speeds up, and slows down before the end,
         * CubicBezier(0.25, 0.1, 0.25, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        Ease,

        /**
         * EaseIn. Indicates that the animation starts at a low speed, Cubic Bezier (0.42, 0.0, 1.0, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        EaseIn,

        /**
         * EaseOut. Indicates that the animation ends at low speed, CubicBezier (0.0, 0.0, 0.58, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        EaseOut,

        /**
         * EaseInOut. Indicates that the animation starts and ends at low speed, CubicBezier (0.42, 0.0, 0.58, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        EaseInOut,
         
        /**
         * FastOutSlowIn. Standard curve, cubic-bezier (0.4, 0.0, 0.2, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        FastOutSlowIn,

        /**
         * LinearOutSlowIn. Deceleration curve, cubic-bezier (0.0, 0.0, 0.2, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        LinearOutSlowIn,

        /**
         * FastOutLinearIn. Acceleration curve, cubic-bezier (0.4, 0.0, 1.0, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        FastOutLinearIn,

        /**
         * ExtremeDeceleration. Abrupt curve, cubic-bezier (0.0, 0.0, 0.0, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        ExtremeDeceleration,

        /**
         * Sharp. Sharp curves, cubic-bezier (0.33, 0.0, 0.67, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        Sharp,

        /**
         * Rhythm. Rhythmic curve, cubic-bezier (0.7, 0.0, 0.2, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        Rhythm,

        /**
         * Smooth. Smooth curves, cubic-bezier (0.4, 0.0, 0.4, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        Smooth,

        /**
         * Friction. Damping curves, CubicBezier (0.2, 0.0, 0.2, 1.0).
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        Friction
    }

    /**
     * Interface for curve object.
     *
     * @interface ICurve
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export interface ICurve {
        /**
         * Get curve value by fraction.
         *
         * @param { number } fraction -Indicates the current normalized time parameter. Value range: [0, 1].
         *     Note: If the value is less than 0, it will be processed as 0. If the value is greater than 1, 1 is used.
         * @returns { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        interpolate(fraction: number): number;
    }

    /**
     * Implements initialization for the interpolation curve,
     * which is used to create an interpolation curve based on the input parameter.
     *
     * @param { Curve } [curve] - Curve type.<br>Default value: **Curve.Linear**.
     * @returns { ICurve }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function initCurve(curve?: Curve): ICurve;

    /**
     * Creates a step curve.
     *
     * @param { number } count - Number of steps. The value must be a positive integer.<br>Value range: [1, +∞).
     * <p>**NOTE**:
     * <br>A value less than 1 evaluates to the value **1**.
     * </p>
     * @param { boolean } end -Whether jumping occurs when the interpolation ends.
     * **true**: Jumping occurs when the interpolation ends.
     * *false**: Jumping occurs when the interpolation starts.
     * @returns { ICurve } Interpolation curve.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function stepsCurve(count: number, end: boolean): ICurve;
    
    /**
     * Creates a custom curve.
     *
     * @param { function } interpolate - Custom interpolation callback.fraction: input x value for interpolation.
     * when the animation starts. Value range: [0, 1]The return value is the y value of the curve. Value range: [0, 1].
     * <p>**NOTE**:
     * <br>If fraction is 0, the return value 0 corresponds to the animation start point; any other return value means that
     * <br>the animation jumps at the start point.If fraction is 1, the return value 1 corresponds to the animation
     * <br>end point; any other return value means that the end value of the animation is not the value of the state
     * <br>variable, which will result in an effect of transition from that end value to the value of the state variable.
     * </p>
     * @returns { ICurve } Interpolation curve.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function customCurve(interpolate: (fraction: number) => number): ICurve;

    /**
     * Creates a cubic Bezier curve. The curve values must be between 0 and 1.
     *
     * @param { number } x1 - X coordinate of the first point on the Bezier curve.<br>Value range: [0, 1].
     * <p>**NOTE**:
     * <br>A value less than 0 is handed as **0**. A value greater than 1 is handed as **1**.
     * </p>
     * @param { number } y1 - Y coordinate of the first point on the Bezier curve.<br>Value range: (-∞, +∞).
     * @param { number } x2 - X coordinate of the second point on the Bezier curve.<br>Value range: [0, 1].
     * <p>**NOTE**:
     * <br>A value less than 0 is handed as **0**. A value greater than 1 is handed as **1**.
     * </p>
     * @param { number } y2 - Y coordinate of the second point on the Bezier curve.<br>Value range: (-∞, +∞).
     * @returns { ICurve } Interpolation curve.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function cubicBezierCurve(x1: number, y1: number, x2: number, y2: number): ICurve;

    /**
     * Creates a spring curve. The curve shape is subject to the spring parameters, and the animation duration
     * is subject to the **duration** parameter in **animation** and **animateTo**.
     *
     * @param { number } velocity - Initial velocity. It is applied by external factors to the spring animation,
     * designed to help ensure the smooth transition from the previous motion state. The velocity is the normalized
     * velocity, and its value is equal to the actual velocity at the beginning of the animation divided by the
     * animation attribute change value.Value range: (-∞, +∞).
     * @param { number } mass - Mass, which influences the inertia in the spring system. The greater the mass,
     * the greater the amplitude of the oscillation, and the slower the speed of restoring to the equilibrium position.
     * Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the value 1 is used.
     * </p>
     * @param { number } stiffness - Stiffness.It is the degree to which an object deforms by resisting the force
     * applied. In an elastic system, the greater the stiffness, the stronger the ability to resist deformation,
     * and the faster the speed of restoring to the equilibrium position.Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the value 1 is used.
     * </p>
     * @param { number } damping -Damping. It is used to describe the oscillation and attenuation of the system
     * after being disturbed. The larger the damping, the smaller the number of oscillations of elastic motion,
     * and the smaller the oscillation amplitude.Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the value 1 is used.
     * </p>
     * @returns { ICurve } Interpolation curve.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function springCurve(velocity: number, mass: number, stiffness: number, damping: number): ICurve;

    /**
     * Creates a spring animation curve.
     * If multiple spring animations are applied to the same attribute of an object,
     * each animation replaces their predecessor and inherits the velocity.
     *
     * @param { number } [response] Duration of one complete oscillation.
     * <br>Default value: **0.55**.<br>Unit: second<br>Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the default value **0.55** is used.
     * </p>
     * @param { number } [dampingFraction] Damping coefficient.
     * **0**: undamped. In this case, the spring oscillates forever.<br>> 0 and < 1: underdamped.
     * In this case, the spring overshoots the equilibrium position.<br>**1**: critically damped.
     * 1: overdamped. In this case, the spring approaches equilibrium gradually.<br>Default value: **0.825**.
     * Unit: second.
     * Value range: [0, +∞).
     * <p>**NOTE**:
     * <br>A value less than 0 evaluates to the default value **0.825**.
     * </p>
     * @param { number } [overlapDuration]  Duration for animations to overlap, in seconds.
     * When animations overlap, the **response** values of these animations will transit smoothly over this duratio
     * if they are different.<br>Default value: **0**<br>Unit: second<br>Value range: [0, +∞).
     * <p>**NOTE**
     * <br>A value less than 0 evaluates to the default value **0**.
     * <br>The spring animation curve is physics-based. Its duration depends on the **springMotion** parameters and
     * the previous velocity, rather than the **duration** parameter in animation, animateTo, or pageTransition.
     * The time cannot be normalized. Therefore, the interpolation cannot be obtained using
     * the **interpolate** function of the curve.
     * </p>
     * @returns { ICurve }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function springMotion(response?: number, dampingFraction?: number, overlapDuration?: number): ICurve;

    /**
     * Creates a responsive spring animation curve. It is a special case of [springMotion](#curvesspringmotion9),
     * with the only difference in the default values. It can be used together with **springMotion**.
     *
     * @param { number } [response] See **response** in **springMotion**.<br>Default value: **0.15**.
     * Unit: second<br>Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the default value **0.15** is used.
     * </p>
     * @param { number } [dampingFraction] See **dampingFraction** in **springMotion**.<br>Default value: **0.86**.
     * Unit: second<br>Value range: [0, +∞).
     * <p>**NOTE**
     * <br>A value less than 0 evaluates to the default value **0.86**.
     * </p>
     * @param { number } [overlapDuration] See **overlapDuration** in **springMotion**.<br>Default value: **0.25**.
     * Unit: second<br>Value range: [0, +∞).
     * <p>**NOTE**:
     * <br>A value less than 0 evaluates to the default value **0.25**.
     * <br>To apply custom settings for a spring animation, you are advised to use **springMotion**.
     * <br>When using **responsiveSpringMotion**, you are advised to retain the default settings.
     * <br>The duration of the responsive spring animation depends on the **responsiveSpringMotion** parameters and the
     * previous velocity, rather than the duration parameter in animation, animateTo, or pageTransition.
     * <br>In addition, the interpolation cannot be obtained using the **interpolate** function of the curve.
     * </p>
     * @returns { ICurve }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function responsiveSpringMotion(response?: number, dampingFraction?: number, overlapDuration?: number): ICurve;
    
    /**
     * Creates an interpolating spring curve animated from 0 to 1. The actual animation value is calculated based
     * on the curve. The animation duration is subject to the curve parameters, rather than the **duration** parameter
     * in **animation** or **animateTo**.
     *
     * @param { number } velocity - Initial velocity. It is applied by external factors to the spring animation,
     * designed to help ensure the smooth transition from the previous motion state.
     * The velocity is the normalized velocity, and its value is equal to the actual velocity at the beginning of
     * the animation divided by the animation attribute change value.<br>Value range: (-∞, +∞).
     * @param { number } mass - Mass, which influences the inertia in the spring system. The greater the mass,
     * the greater the amplitude of the oscillation, and the slower the speed of restoring to the equilibrium position.
     * <br>Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the value **1** is used.
     * </p>
     * @param { number } stiffness - Stiffness. It is the degree to which an object deforms by resisting
     * the force applied. In an elastic system, the greater the stiffness, the stronger the ability to resist
     * deformation, and the faster the speed of restoring to the equilibrium position.<br>Value range: (0, +∞).
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the value **1** is used.
     * </p>
     * @param { number } damping - Damping. It is used to describe the oscillation and attenuation of the system
     * after being disturbed. The larger the damping, the smaller the number of oscillations of elastic motion,
     * and the smaller the oscillation amplitude.<br>Value range: (0, +∞)<br>
     * <p>**NOTE**:
     * <br>If this parameter is set to a value less than or equal to 0, the value **1** is used.
     * </p>
     * @returns { ICurve }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function interpolatingSpring(velocity: number, mass: number, stiffness: number, damping: number): ICurve;
}
export default curves;
