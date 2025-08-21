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
import { Resource } from '../../global/resource';
import { ResourceColor } from "./units";
import { FontWeight } from "./enums";
import { CommonMethod, Optional, AttributeModifier } from "./common";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
/**
 * The symbol rendering strategy.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SymbolRenderingStrategy {
    /**
     * The single rendering strategy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SINGLE = 0,
    /**
     * The multiple color rendering strategy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MULTIPLE_COLOR = 1,
    /**
     * The multiple opacity rendering strategy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MULTIPLE_OPACITY = 2
}
/**
 * The symbol effect strategy.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SymbolEffectStrategy {
    /**
     * There is no effect strategy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * The scale effect strategy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SCALE = 1,
    /**
     * The hierarchical effect strategy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HIERARCHICAL = 2
}
/**
 * The direction type of symbol effect
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EffectDirection {
    /**
     * The scale down animation of symbol
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DOWN = 0,
    /**
     * The scale up animation of symbol
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    UP = 1
}
/**
 * Declare scope type of the symbol effect
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EffectScope {
    /**
     * The layered animation of symbol
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LAYER = 0,
    /**
     * The whole animation of symbol
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WHOLE = 1
}
/**
 * Declare fill style of symbol
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EffectFillStyle {
    /**
     * The cumulative fill style of symbol
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CUMULATIVE = 0,
    /**
     * The iterative fill style of symbol
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ITERATIVE = 1
}
/**
 * Defines SymbolEffect class.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SymbolEffect {
}
/**
 * Defines ScaleSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ScaleSymbolEffect extends SymbolEffect {
    /**
     * constructor.
     *
     * @param { EffectScope } [scope] -  The scope type of symbol effect.
     * @param { EffectDirection } [direction] - The direction of symbol effect.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(scope?: EffectScope, direction?: EffectDirection);
    /**
     * The scope type of symbol effect
     *
     * @type { ?EffectScope }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scope?: EffectScope;
    /**
     * The direction of symbol effect
     *
     * @type { ?EffectDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: EffectDirection;
}
/**
 * Defines HierarchicalSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class HierarchicalSymbolEffect extends SymbolEffect {
    /**
     * constructor.
     *
     * @param { EffectFillStyle } [fillStyle] -  The fill style of symbol effect.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(fillStyle?: EffectFillStyle);
    /**
     * The fill style of symbol effect
     *
     * @type { ?EffectFillStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fillStyle?: EffectFillStyle;
}
/**
 * Defines AppearSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class AppearSymbolEffect extends SymbolEffect {
    /**
     * constructor.
     *
     * @param { EffectScope } [scope] -  The scope type of symbol effect.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(scope?: EffectScope);
    /**
     * The scope type of symbol effect
     *
     * @type { ?EffectScope }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scope?: EffectScope;
}
/**
 * Defines DisappearSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class DisappearSymbolEffect extends SymbolEffect {
    /**
     * constructor.
     *
     * @param { EffectScope } [scope] -  The scope type of symbol effect.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(scope?: EffectScope);
    /**
     * The scope type of symbol effect
     *
     * @type { ?EffectScope }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scope?: EffectScope;
}
/**
 * Defines BounceSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class BounceSymbolEffect extends SymbolEffect {
    /**
     * constructor.
     *
     * @param { EffectScope } [scope] -  The scope type of symbol effect.
     * @param { EffectDirection } [direction] - The direction of symbol effect.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(scope?: EffectScope, direction?: EffectDirection);
    /**
     * The scope type of symbol effect
     *
     * @type { ?EffectScope }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scope?: EffectScope;
    /**
     * The direction of symbol effect
     *
     * @type { ?EffectDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: EffectDirection;
}
/**
 * Defines ReplaceSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ReplaceSymbolEffect extends SymbolEffect {
    /**
     * constructor.
     *
     * @param { EffectScope } [scope] -  The scope type of symbol effect.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(scope?: EffectScope);
    /**
     * The scope type of symbol effect
     *
     * @type { ?EffectScope }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scope?: EffectScope;
}
/**
 * Defines PulseSymbolEffect class.
 *
 * @extends SymbolEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PulseSymbolEffect extends SymbolEffect {
}
/**
 * Provides attribute for SymbolGlyph.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface SymbolGlyphAttribute extends CommonMethod {
    /**
     * Called when the SymbolGlyph size is set.
     *
     * @param { number | string | Resource } value
     * @returns { SymbolGlyphAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the SymbolGlyph color is set.
     *
     * @param { Array<ResourceColor> } value
     * @returns { SymbolGlyphAttribute } The attribute of the SymbolGlyph.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontColor(value: Array<ResourceColor> | undefined): this;
    /**
     * Called when the font symbolGlyph weight is set.
     *
     * @param { number | FontWeight | string } value
     * @returns { SymbolGlyphAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontWeight(value: number | FontWeight | string | undefined): this;
    /**
     * Called when the symbolGlyph effect is set.
     *
     * @param { SymbolEffectStrategy } value
     * @returns { SymbolGlyphAttribute } The attribute of the SymbolGlyph.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default effectStrategy(value: SymbolEffectStrategy | undefined): this;
    /**
     * Called when the symbolGlyph rendering strategy is set.
     *
     * @param { SymbolRenderingStrategy } value
     * @returns { SymbolGlyphAttribute } The attribute of the SymbolGlyph.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default renderingStrategy(value: SymbolRenderingStrategy | undefined): this;
    /**
     *  Define effect options for SymbolGlyph.
     *
     * @param { SymbolEffect } [symbolEffect] - The symbol effect type
     * @param { boolean | number } [triggerValue] - The trigger of the effect
     * @returns { SymbolGlyphAttribute } The attribute of the SymbolGlyph.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default symbolEffect(symbolEffect: SymbolEffect | undefined, triggerValue?: boolean | number | undefined): this;
    /**
     * Called when the minimum font scale of the font is set.
     *
     * @param { Optional<number|Resource> } scale
     * @returns { SymbolGlyphAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontScale(scale: number | Resource | undefined): this;
    /**
     * Called when the maximum font scale of the font is set.
     *
     * @param { Optional<number|Resource> } scale
     * @returns { SymbolGlyphAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontScale(scale: number | Resource | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<SymbolGlyphAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { SymbolGlyphAttribute } the attribute of the SymbolGlyphAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<SymbolGlyphAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines SymbolGlyph Component.
 *
 * @param { Resource } [value]
 * @param { function } [content_]
 * @returns { SymbolGlyphAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function SymbolGlyph(
    value?: Resource, 
    @memo
    content_?: () => void,
): SymbolGlyphAttribute
