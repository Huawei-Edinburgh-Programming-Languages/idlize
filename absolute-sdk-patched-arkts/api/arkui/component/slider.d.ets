'use static'
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
import { CommonMethod, CommonConfiguration, ContentModifier, Optional, Bindable } from './common';
import { Axis, CrownSensitivity } from './enums';
import { ResourceStr, ResourceColor, Length, Dimension, SizeOptions } from './units';
import { CircleAttribute } from './circle';
import { RectAttribute } from './rect';
import { PathAttribute } from './path';
import { EllipseAttribute } from './ellipse';
import { LinearGradient } from './dataPanel';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Style of the slider thumb and track.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SliderStyle {
    /**
     * The thumb is on the track.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    OutSet,
    /**
     * The thumb is in the track.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    InSet,
    /**
     * There is no thumb.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE
}
/**
 * State triggered by the event.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SliderChangeMode {
    /**
     * The user touches or clicks the thumb.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Begin,
    /**
     * The user is dragging the slider.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Moving,
    /**
     * The user stops dragging the slider by lifting their finger or releasing the mouse device.
     * <p><strong>NOTE</strong>:
     * <br>The trigger occurs when an invalid value is restored to the default value, that is, when the value is set to
     * less than min or greater than max.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End,
    /**
     * The user moves the thumb by touching or clicking the track.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Click
}
/**
 * Interaction mode between the user and the slider.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SliderInteraction {
    /**
     * Users can drag the slider or touch the track to move the slider. The slider moves as soon as the mouse or
     * finger is pressed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SLIDE_AND_CLICK,
    /**
     * Users are not allowed to move the slider by touching the slider.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SLIDE_ONLY,
    /**
     * Users can drag the slider or touch the track to move the slider. The slider moves when the mouse is released or
     * finger is lifted, if the release/lift position coincides with the screen press position.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SLIDE_AND_CLICK_UP = 2
}
/**
 * Defines the callback type used in SlideRange.
 * <p><strong>NOTE</strong>:
 * <br>Currently, this API takes effect only when MIN ≤ from ≤ to ≤ MAX (the values of MIN and MAX do not depend on
 * the values set, but on the actual values that take effect). You can set either from or to, or you can set both from
 * and to. When the API is effective, if the set from value is between the adjacent multiples of step, then from takes
 * the value of the left interval multiple of step or MIN as the corrected value. When the API is effective, if the set
 * to value is between the adjacent multiples of step, then to takes the value of the right interval multiple of step
 * or MAX as the corrected value. After from and to have taken their corrected values, when value is undefined or null,
 * it takes the same value as from; when value is a number type, and if value ≤ from, then it takes from;
 * if value > to, then it takes to.
 * </p>
 *
 * @interface SlideRange
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SlideRange {
    /**
     * Start of the slide range.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    from?: number;
    /**
     * End of the slide range.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    to?: number;
}
/**
 * Parameters of the slider.
 *
 * @interface SliderOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SliderOptions {
    /**
     * Current value of Slider.
     *
     * @type { ?(number| undefined | Bindable<number>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value?: number | undefined | Bindable<number>;
    /**
     * Minimum value.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    min?: number;
    /**
     * Maximum value.
     * <p><strong>NOTE</strong>:
     * <br>If the value of min is greater than or equal to the value of max, the min value defaults to 0, and the max
     * value defaults to 100. If the value is not within the [min, max] range, the value of min or max is used,
     * whichever is closer.
     * </p>
     *
     * @type { ?number }
     * @default 100
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    max?: number;
    /**
     * Step of the slider.
     * <p><strong>NOTE</strong>:
     * <br>If this parameter is set to a value less than 0 or greater than the value of max, the default value is used.
     * </p>
     *
     * @type { ?number }
     * @default 1 - Value range: [0.01, max - min]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    step?: number;
    /**
     * Style of the slider thumb and track.
     *
     * @type { ?SliderStyle }
     * @default SliderStyle.OutSet
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: SliderStyle;
    /**
     * Whether the slider moves horizontally or vertically.
     *
     * @type { ?Axis }
     * @default Axis.Horizontal
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: Axis;
    /**
     * Whether the slider values are reversed. By default, the values increase from left to right for a horizontal
     * slider and from top to bottom for a vertical slider.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    reverse?: boolean;
}
/**
 * Enumerates the types of the slider in the block direction.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SliderBlockType {
    /**
     * Round slider.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT,
    /**
     * Slider with an image background.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IMAGE,
    /**
     * Slider in a custom shape.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SHAPE
}
/**
 * Describes the style of the slider in the block direction.
 *
 * @interface SliderBlockStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SliderBlockStyle {
    /**
     * Type of the slider in the block direction.
     *
     * @type { SliderBlockType }
     * @default SliderBlockType.DEFAULT - indicating the round slider.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: SliderBlockType;
    /**
     * Image resource of the slider. The area size for displaying the image is subject to the blockSize attribute.
     * Be mindful of the image size when selecting an image.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    image?: ResourceStr;
    /**
     * Custom shape of the slider.
     *
     * @type { ?(CircleAttribute | EllipseAttribute | PathAttribute | RectAttribute) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    shape?: CircleAttribute | EllipseAttribute | PathAttribute | RectAttribute;
}
/**
 * Defines the callback type used in SliderConfiguration.
 *
 * @typedef {function} SliderTriggerChangeCallback
 * @param { number } value - Current progress.
 * @param { SliderChangeMode } mode - State triggered by the event.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type SliderTriggerChangeCallback = (value: number, mode: SliderChangeMode) => void;
/**
 * You need a custom class to implement the ContentModifier API.
 *
 * @extends CommonConfiguration<SliderConfiguration>
 * @interface SliderConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SliderConfiguration extends CommonConfiguration<SliderConfiguration> {
    /**
     * Current progress.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: number;
    /**
     * Minimum value.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    min: number;
    /**
     * Maximum value.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    max: number;
    /**
     * Step of the slider.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    step: number;
    /**
     * Triggers slider changes.
     *
     * @type { SliderTriggerChangeCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    triggerChange: SliderTriggerChangeCallback;
}

/**
 * Defines the attribute functions of Slider.
 *
 * @extends CommonMethod
 * @interface SliderAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SliderAttribute extends CommonMethod {
    /**
     * Called when the slider color of the slider bar is set.
     *
     * @param { ResourceColor | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    blockColor(value: ResourceColor | undefined): this;
    /**
     * Called when the track color of the slider is set.
     *
     * @param { ResourceColor | LinearGradient | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackColor(value: ResourceColor | LinearGradient | undefined): this;
    /**
     * Called when the slider of the slider bar is set to slide over the area color.
     *
     * @param { ResourceColor | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedColor(value: ResourceColor | undefined): this;
    /**
     * Called when the slider of the slider bar is set to slide over the area color.
     *
     * @param { ResourceColor | LinearGradient | undefined } selectedColor
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedColor(selectedColor: ResourceColor | LinearGradient | undefined): this;
    /**
     * Called when setting whether to display step size.
     *
     * @param { boolean | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    showSteps(value: boolean | undefined): this;
    /**
     * Called when the percentage of bubble prompt is set when sliding.
     *
     * @param { boolean | undefined } value - Whether to display the bubble.
     * @param { ResourceStr | undefined } [content] - Text content in the bubble. If the content is not specified,
     *     the current percentage is displayed by default.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    showTips(value: boolean | undefined, content?: ResourceStr | undefined): this;
    /**
     * Called when the thickness of track is set.
     *
     * @param { Length | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackThickness(value: Length | undefined): this;
    /**
     * Triggered when the slider is dragged or clicked.
     * <p><strong>NOTE</strong>:
     * <br>The Begin and End states are triggered when the slider is clicked with a gesture. The Moving and Click states
     * are triggered when the value of value changes. If the coherent action is a drag action, the Click state will
     * not be triggered.
     * </p>
     *
     * @param { ((value: number, mode: SliderChangeMode) => void) | undefined } callback
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: ((value: number, mode: SliderChangeMode) => void) | undefined): this;
    /**
     * Called when the border color of block is set.
     *
     * @param { ResourceColor | undefined } value - the border color of block.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    blockBorderColor(value: ResourceColor | undefined): this;
    /**
     * Called when the border width of block is set.
     *
     * @param { Length | undefined } value - the border width of block.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    blockBorderWidth(value: Length | undefined): this;
    /**
     * Called when the color of step is set.
     *
     * @param { ResourceColor | undefined } value - the color of step.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stepColor(value: ResourceColor | undefined): this;
    /**
     * Called when the radius of track border is set.
     *
     * @param { Length | undefined } value - the radius of track border.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackBorderRadius(value: Length | undefined): this;
    /**
     * Called when the radius of selected part is set.
     *
     * @param { Dimension | undefined } value - the radius of selected part.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedBorderRadius(value: Dimension | undefined): this;
    /**
     * Called when the size of block is set.
     *
     * @param { SizeOptions | undefined } value - the size of block.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    blockSize(value: SizeOptions | undefined): this;
    /**
     * Sets the style of the slider in the block direction.
     *
     * @param { SliderBlockStyle | undefined } value - Style of the slider in the block direction.
     *     <br>Default value is SliderBlockType.DEFAULT, indicating the round slider.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    blockStyle(value: SliderBlockStyle | undefined): this;
    /**
     * Called when the diameter of step is set.
     *
     * @param { Length | undefined } value - the diameter of step.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stepSize(value: Length | undefined): this;
    /**
     * Sets the interaction mode between the user and the slider.
     *
     * @param { SliderInteraction | undefined } value - Interaction mode between the user and the slider.
     *     <br>Default value is SliderInteraction.SLIDE_AND_CLICK.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sliderInteractionMode(value: SliderInteraction | undefined): this;
    /**
     * Sets the min value when Slider response to drag event.
     *
     * @param { number | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    minResponsiveDistance(value: number | undefined): this;
    /**
     * Creates a content modifier.
     *
     * @param { ContentModifier<SliderConfiguration> | undefined } modifier - Content modifier to apply to the slider.
     *     modifier: content modifier. You need a custom class to implement the ContentModifier API.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<SliderConfiguration> | undefined): this;
    /**
     * Set the valid slidable range.
     *
     * @param { SlideRange | undefined } value
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    slideRange(value: SlideRange | undefined): this;
    /**
     * Set the sensitivity of rotating crown.
     *
     * @param { CrownSensitivity | undefined } sensitivity - The sensitivity of rotating crown, default value is
     *     { MEDIUM }.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    digitalCrownSensitivity(sensitivity: CrownSensitivity | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * @param { boolean | undefined } enabled - Default value is true, set false to disable haptic feedback.
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback(enabled: boolean | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<SliderAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { SliderAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(modifier: AttributeModifier<SliderAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Slider Component.
 *
 * @param { SliderOptions } [options] - The options
 * @param { function } [content_] - container
 * @returns { SliderAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Slider(
    options?: SliderOptions, 
    @memo
    content_?: () => void,
): SliderAttribute