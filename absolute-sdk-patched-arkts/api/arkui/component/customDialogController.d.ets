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
import { Rectangle, AnimateParam, Callback, ShadowOptions, ShadowStyle, KeyboardAvoidMode, BlurStyle, HoverModeAreaType, DismissReason, BackgroundBlurStyleOptions, BackgroundEffectOptions } from './common';
import { CustomBuilder } from './builder';
import { ExtendableComponent } from './extendableComponent';
import { DialogAlignment } from './alertDialog';
import { Offset, ResourceColor, Dimension, BorderRadiuses, EdgeWidths, EdgeColors, EdgeStyles } from './units';
import { BorderStyle } from './enums';
import { LengthMetrics } from '../Graphics';
import { LevelMode, LevelOrder, ImmersiveMode } from '../../@ohos.promptAction';
import { CustomBuilder } from './builder';
import { DismissDialogAction } from './actionSheet';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the options of CustomDialogController.
 *
 * @interface CustomDialogControllerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CustomDialogControllerOptions {
    /**
     * Custom builder function.
     *
     * @type { CustomBuilder | ExtendableComponent }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    builder: CustomBuilder | ExtendableComponent;
    /**
     * Defines the cancel function.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cancel?: () => void;
    /**
     * Defines if use auto cancel when click on the outside of the dialog.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    autoCancel?: boolean;
    /**
     * Defines the dialog alignment of the screen.
     *
     * @type { ?DialogAlignment }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignment?: DialogAlignment;
    /**
     * Defines the dialog offset.
     *
     * @type { ?Offset }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: Offset;
    /**
     * Defines if use custom style.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    customStyle?: boolean;
    /**
     * Grid count of dialog.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gridCount?: number;
    /**
     * Mask color of dialog.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maskColor?: ResourceColor;
    /**
     * Mask Region of dialog. The size cannot exceed the main window.
     *
     * @type { ?Rectangle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maskRect?: Rectangle;
    /**
     * Animation parameters of dialog opening.
     *
     * @type { ?AnimateParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    openAnimation?: AnimateParam;
    /**
     * Animation parameters of dialog closing.
     *
     * @type { ?AnimateParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    closeAnimation?: AnimateParam;
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
     * Background color of dialog.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Corner radius of dialog.
     *
     * @type { ?(Dimension | BorderRadiuses) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cornerRadius?: Dimension | BorderRadiuses;
    /**
     * Whether it is a modal dialog
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isModal?: boolean;
    /**
     * Callback function when the CustomDialog interactive dismiss.
     *
     * @type { ?Callback<DismissDialogAction> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillDismiss?: Callback<DismissDialogAction>;
    /**
     * Defines the custom dialog's width.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: Dimension;
    /**
     * Defines the custom dialog's height.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: Dimension;
    /**
     * Defines the custom dialog's border width.
     *
     * @type { ?(Dimension | EdgeWidths) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderWidth?: Dimension | EdgeWidths;
    /**
     * Defines the custom dialog's border color.
     *
     * @type { ?(ResourceColor | EdgeColors) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderColor?: ResourceColor | EdgeColors;
    /**
     * Defines the custom dialog's border style.
     *
     * @type { ?(BorderStyle | EdgeStyles) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderStyle?: BorderStyle | EdgeStyles;
    /**
     * Defines the custom dialog's shadow.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Defines the customDialog's background blur Style
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Defines the customDialog's background blur style with options
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;
    /**
     * Defines the customDialog's background effect with options
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;
    /**
     * Defines the customDialog's keyboard avoid mode
     *
     * @type { ?KeyboardAvoidMode }
     * @default KeyboardAvoidMode.DEFAULT
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    keyboardAvoidMode?: KeyboardAvoidMode;
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
     * Defines the customDialog's display area in hover mode.
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
     * Defines the distance between the customDialog and system keyboard.
     *
     * @type { ?LengthMetrics }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    keyboardAvoidDistance?: LengthMetrics;
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
    /**
     * Specifies whether to get focus when the custom dialog is displayed.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    focusable?: boolean;
}
/**
 * Defines the external options of CustomDialogController.
 *
 * @interface CustomDialogControllerExternalOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CustomDialogControllerExternalOptions {
    /**
     * Defines if use custom style.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    customStyle?: boolean;
}
/**
 * Use the CustomDialogController class to display the custom pop-up window.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class CustomDialogController {
    /**
     * The constructor transfers parameter settings.
     *
     * @param { CustomDialogControllerOptions } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(value: CustomDialogControllerOptions);
    /**
     * Display the content of the customized pop-up window. If the content has been displayed, it does not take effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    open(): void;
    /**
     * Closes the custom pop-up window. If the window is closed, the window does not take effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    close(): void;
    /**
     * Obtains the external options of CustomDialogController.
     *
     * @returns { CustomDialogControllerExternalOptions } return the external options of dialog.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getExternalOptions(): CustomDialogControllerExternalOptions;
}
