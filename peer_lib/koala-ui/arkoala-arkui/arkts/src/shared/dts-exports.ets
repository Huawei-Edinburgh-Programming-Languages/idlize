/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { AdaptiveColor,
         BackgroundBlurStyleOptions,
         BorderStyle,
         BlurStyle,
         BlurOptions,
         CustomBuilder,
         DismissReason,
         DragInteractionOptions,
         DragPreviewMode,
         DragPreviewOptions,
         EdgeWidths,
         GradientDirection,
         ShadowStyle,
         ShadowType,
         SheetMode,
         SheetSize,
         SheetOptions,
         SheetType,
         SourceTool,
         StateStyles,
         SymbolGlyphModifier,
         RectResult,
         ThemeColorMode,
         UIGestureEvent } from '@arkoala/arkui/ArkCommonInterfaces'
import { GestureInterface
         GestureJudgeResult,
         GestureMask,
         GesturePriority } from '@arkoala/arkui/ArkGestureInterfaces'
import { CalendarAlign } from '@arkoala/arkui/ArkCalendarPickerInterfaces'
import { EnumDTS } from '@arkoala/arkui/ArkTestInterfaces'
import { NavigationTitleMode } from '@arkoala/arkui/ArkNavigationInterfaces'
import { HorizontalAlign } from '@arkoala/arkui/ArkColumnInterfaces'
import { SelectedMode } from '@arkoala/arkui/ArkTabContentInterfaces'
import { BarMode } from '@arkoala/arkui/ArkTabsInterfaces'
import { Color,
         ColoringStrategy,
         FontWeight,
         FontStyle,
         TextHeightAdaptivePolicy,
         TextOverflow } from '@arkoala/arkui/ArkEnumInterfaces'
import { Dimension,
         Font,
         Length,
         LengthMetrics,
         LengthMetricsUnit,
         LocalizedPadding,
         Resource,
         ResourceColor,
         ResourceStr } from "@arkoala/arkui/ArkUnitsInterfaces"
import { NativeEmbedDataInfo } from '@arkoala/arkui/ArkWebInterfaces'

declare class Indicator<T> {}

export class DotIndicator extends Indicator<DotIndicator> {
  constructor() {}
  itemWidth(value: Length): DotIndicator {
    return this;
  }
  itemHeight(value: Length): DotIndicator {
    return this;
  }
}

export type External_LITERAL_evenodd = string
export type External_LITERAL_onzero = string
export type External_LITERAL_nonzero = string
export type External_TEMPLATE_LITERAL_number_FP = string
export type External_TEMPLATE_LITERAL_number_LPX = string
export type External_TEMPLATE_LITERAL_number_vp = string
export type External_TEMPLATE_LITERAL_number_Percentage = string
export type External_TEMPLATE_LITERAL_number_PX = string
