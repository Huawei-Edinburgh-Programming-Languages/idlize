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
import { ResourceStr, ResourceColor, VoidCallback, Offset, Dimension, BorderRadiuses, LocalizedBorderRadiuses, EdgeWidths, LocalizedEdgeWidths, EdgeColors, LocalizedEdgeColors, EdgeStyles } from './units';
import { WordBreak, DialogButtonStyle, BorderStyle } from './enums';
import { Rectangle, BlurStyle, Callback, TransitionEffect, ShadowOptions, ShadowStyle, HoverModeAreaType, DismissReason, BackgroundBlurStyleOptions, BackgroundEffectOptions } from './common';
import { LevelOrder, ImmersiveMode, LevelMode } from '../../@ohos.promptAction';
import { DismissDialogAction } from './actionSheet';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * The alignment of dialog,
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum DialogAlignment {
    /**
     * Vertical top alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Top,
    /**
     * Align vertically to the center.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * Vertical bottom alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bottom,
    /**
     * Default alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Default,
    /**
     * Align the upper left corner.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TopStart,
    /**
     * Align the upper right corner.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TopEnd,
    /**
     * Left center alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CenterStart,
    /**
     * Right center alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CenterEnd,
    /**
     * Align the lower left corner.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BottomStart,
    /**
     * Align the lower right corner.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BottomEnd
}
/**
* The arrangement of buttons in dialog.
*
* @enum { number }
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @since 20
*/
export declare enum DialogButtonDirection {
    /**
     * Two or fewer buttons are arranged horizontally,
     * and two or more buttons are arranged vertically.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    AUTO = 0,
    /**
     * Buttons are arranged horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HORIZONTAL = 1,
    /**
     * Buttons are arranged vertically.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    VERTICAL = 2
}
/**
 * Base button param.
 *
 * @interface AlertDialogButtonBaseOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogButtonBaseOptions {
    /**
     * Enable switch of button.
     * Anonymous Object Rectification.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enabled?: boolean;
    /**
     * Default focus switch of button.
     * Anonymous Object Rectification.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    defaultFocus?: boolean;
    /**
     * Style of button.
     * Anonymous Object Rectification.
     *
     * @type { ?DialogButtonStyle }
     * @default -
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: DialogButtonStyle;
    /**
     * Text content of button.
     * Anonymous Object Rectification.
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: ResourceStr;
    /**
     * Text color of button.
     * Anonymous Object Rectification.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor?: ResourceColor;
    /**
     * Background color of button.
     * Anonymous Object Rectification.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Method executed by the callback.
     * Anonymous Object Rectification.
     *
     * @type { VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    action: VoidCallback;
}
/**
 * Button param used for AlertDialogParamWithOptions.
 *
 * @extends AlertDialogButtonBaseOptions
 * @interface AlertDialogButtonOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogButtonOptions extends AlertDialogButtonBaseOptions {
    /**
     * Define whether the button responds to Enter/Space key by default.
     * Anonymous Object Rectification.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    primary?: boolean;
}
/**
 * Defines TextStyle in the AlertDialog.
 *
 * @interface AlertDialogTextStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogTextStyleOptions {
    /**
     * Set the word break type.
     *
     * @type { ?WordBreak }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    wordBreak?: WordBreak;
}
/**
 * Base param used for AlertDialog.show method.
 *
 * @interface AlertDialogParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogParam {
    /**
     * Title Properties
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    title?: ResourceStr;
    /**
     * Subtitle Properties
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    subtitle?: ResourceStr;
    /**
     * message Properties
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    message: ResourceStr;
    /**
     * Allows users to click the mask layer to exit.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    autoCancel?: boolean;
    /**
     * Execute Cancel Function.
     * Anonymous Object Rectification.
     *
     * @type { ?VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cancel?: VoidCallback;
    /**
     * Alignment in the vertical direction.
     *
     * @type { ?DialogAlignment }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignment?: DialogAlignment;
    /**
     * Offset of the pop-up window relative to the alignment position.
     *
     * @type { ?Offset }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: Offset;
    /**
     * Grid count of dialog.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gridCount?: number;
    /**
     * Mask Region of dialog. The size cannot exceed the main window.
     *
     * @type { ?Rectangle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maskRect?: Rectangle;
    /**
     * Whether to display in the sub window.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    showInSubWindow?: boolean;
    /**
     * Whether it is a modal dialog
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isModal?: boolean;
    /**
     * Defines the alertDialog's background color
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Defines the alertDialog's background blur Style
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Defines the alertDialog's background blur style with options
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;
    /**
     * Defines the alertDialog's background effect with options
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;
    /**
     * Callback function when the dialog interactive dismiss
     *
     * @type { ?Callback<DismissDialogAction> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillDismiss?: Callback<DismissDialogAction>;
    /**
     * Transition parameters of opening/closing AlertDialog.
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    transition?: TransitionEffect;
    /**
     * Defines the alertDialog's corner radius.
     *
     * @type { ?(Dimension | BorderRadiuses | LocalizedBorderRadiuses) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cornerRadius?: Dimension | BorderRadiuses | LocalizedBorderRadiuses;
    /**
     * Defines the alertDialog's width.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: Dimension;
    /**
     * Defines the alertDialog's height.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: Dimension;
    /**
     * Defines the alertDialog's border width.
     *
     * @type { ?(Dimension | EdgeWidths | LocalizedEdgeWidths) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderWidth?: Dimension | EdgeWidths | LocalizedEdgeWidths;
    /**
     * Defines the alertDialog's border color.
     *
     * @type { ?(ResourceColor | EdgeColors | LocalizedEdgeColors) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderColor?: ResourceColor | EdgeColors | LocalizedEdgeColors;
    /**
     * Defines the alertDialog's border style.
     *
     * @type { ?(BorderStyle | EdgeStyles) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderStyle?: BorderStyle | EdgeStyles;
    /**
     * Defines the alertDialog's shadow.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Set the alertDialog's textStyle.
     *
     * @type { ?AlertDialogTextStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle?: AlertDialogTextStyleOptions;
    /**
     * Defines whether to respond to the hover mode.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHoverMode?: boolean;
    /**
     * Defines the alertDialog's display area in hover mode.
     *
     * @type { ?HoverModeAreaType }
     * @default HoverModeAreaType.BOTTOM_SCREEN
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hoverModeArea?: HoverModeAreaType;
    /**
     * Callback function when the dialog appears.
     *
     * @type { ?Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidAppear?: Callback<void>;
    /**
     * Callback function when the dialog disappears.
     *
     * @type { ?Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidDisappear?: Callback<void>;
    /**
     * Callback function before the dialog openAnimation starts.
     *
     * @type { ?Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillAppear?: Callback<void>;
    /**
     * Callback function before the dialog closeAnimation starts.
     *
     * @type { ?Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillDisappear?: Callback<void>;
    /**
     * Determine the display level of the dialog.
     *
     * @type { ?LevelMode }
     * @default LevelMode.OVERLAY
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    levelMode?: LevelMode;
    /**
     * The uniqueId of any node in the router or navigation page.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    levelUniqueId?: number;
    /**
     * Determine the immersive mode of the dialog.
     *
     * @type { ?ImmersiveMode }
     * @default ImmersiveMode.DEFAULT
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    immersiveMode?: ImmersiveMode;
    /**
     * Determine the display order of the dialog.
     *
     * @type { ?LevelOrder }
     * @default The value returns by LevelOrder.clamp(0)
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    levelOrder?: LevelOrder;
}
/**
 * Defines the AlertDialog with confirm button.
 *
 * @extends AlertDialogParam
 * @interface AlertDialogParamWithConfirm
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogParamWithConfirm extends AlertDialogParam {
    /**
     * Invoke the commit function.
     * Anonymous Object Rectification.
     *
     * @type { ?AlertDialogButtonBaseOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    confirm?: AlertDialogButtonBaseOptions;
}
/**
 * Defines the dialog param with buttons.
 *
 * @extends AlertDialogParam
 * @interface AlertDialogParamWithButtons
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogParamWithButtons extends AlertDialogParam {
    /**
     * First button.
     * Anonymous Object Rectification.
     *
     * @type { AlertDialogButtonBaseOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    primaryButton: AlertDialogButtonBaseOptions;
    /**
     * Second button.
     * Anonymous Object Rectification.
     *
     * @type { AlertDialogButtonBaseOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    secondaryButton: AlertDialogButtonBaseOptions;
}
/**
 * Defines the dialog param with options.
 *
 * @extends AlertDialogParam
 * @interface AlertDialogParamWithOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlertDialogParamWithOptions extends AlertDialogParam {
    /**
     * The array of buttons.
     * @type { Array<AlertDialogButtonOptions> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    buttons: Array<AlertDialogButtonOptions>;
    /**
     * The arrangement of buttons.
     * @type { ?DialogButtonDirection }
     * @default DialogButtonDirection.AUTO
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    buttonDirection?: DialogButtonDirection;
}