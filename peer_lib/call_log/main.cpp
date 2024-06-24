
/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
#include "arkoala_api_generated.h"
#include <array>

const GENERATED_ArkUINodeModifiers* GetNodeModifiers() {
    // TODO: restore the proper call
    // return GetFullImpl()->getNodeModifiers();
    extern const GENERATED_ArkUINodeModifiers* GENERATED_GetArkUINodeModifiers();
    return GENERATED_GetArkUINodeModifiers();
}

int main(int argc, const char** argv) {
  const Ark_Length var112_0 = {1, 42.000000, 3, 0};
  GetNodeModifiers()->getCommonMethodModifier()->setWidth((Ark_NativePointer)0x123, &var112_0);
  const Ark_Length var113_0 = {2, 0.000000, 1, 43};
  GetNodeModifiers()->getCommonMethodModifier()->setHeight((Ark_NativePointer)0x123, &var113_0);
  const Opt_Ark_Boolean var291_0 = {ARK_TAG_OBJECT, false};
  const CustomBuilder var292_0 = {0, .value0={42}};
  const Opt_SheetOptions var293_0 = {ARK_TAG_OBJECT, {{ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_OBJECT, {0, .value0={{1, .value1={.kind="NativeErrorResource", .id=0}}, {ARK_TAG_UNDEFINED, {}}}}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}}};
  GetNodeModifiers()->getCommonMethodModifier()->setBindSheet((Ark_NativePointer)0x123, &var291_0, &var292_0, &var293_0);
  const Ark_Int32 var54_0 = 1;
  GetNodeModifiers()->getButtonModifier()->setType((Ark_NativePointer)0x123, var54_0);
  const LabelStyle var65_0 = {{ARK_TAG_UNDEFINED, {}}, {ARK_TAG_OBJECT, {102, .i32=3}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}};
  GetNodeModifiers()->getButtonModifier()->setLabelStyle((Ark_NativePointer)0x123, &var65_0);
  const LabelStyle var65_1 = {{ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}};
  GetNodeModifiers()->getButtonModifier()->setLabelStyle((Ark_NativePointer)0x123, &var65_1);
  const Ark_Int32 var81_0 = 2;
  const Opt_Offset var82_0 = {ARK_TAG_OBJECT, {{1, 5.000000, 1, 0}, {1, 6.000000, 1, 0}}};
  GetNodeModifiers()->getCalendarPickerModifier()->setEdgeAlign((Ark_NativePointer)0x123, var81_0, &var82_0);
  const Ark_Int32 var81_1 = 2;
  const Opt_Offset var82_1 = {ARK_TAG_UNDEFINED, {}};
  GetNodeModifiers()->getCalendarPickerModifier()->setEdgeAlign((Ark_NativePointer)0x123, var81_1, &var82_1);
  const Type_FormComponentAttribute_size_Arg0 var394_0 = {{102, .i32=5}, {102, .i32=6}};
  GetNodeModifiers()->getFormComponentModifier()->setSize((Ark_NativePointer)0x123, &var394_0);
  const Type_FormComponentAttribute_size_Arg0 var394_1 = {{103, .f32=5.50}, {103, .f32=6.78}};
  GetNodeModifiers()->getFormComponentModifier()->setSize((Ark_NativePointer)0x123, &var394_1);
  const Type_FormComponentAttribute_size_Arg0 var394_2 = {{102, .i32=0}, {102, .i32=0}};
  GetNodeModifiers()->getFormComponentModifier()->setSize((Ark_NativePointer)0x123, &var394_2);
  const Ark_Int32 var137_0 = 0;
  const Opt_BackgroundBlurStyleOptions var138_0 = {ARK_TAG_OBJECT, {{ARK_TAG_OBJECT, 0}, {ARK_TAG_OBJECT, 0}, {ARK_TAG_OBJECT, {102, .i32=1}}, {ARK_TAG_OBJECT, {{{102, .i32=1}, {102, .i32=1}}}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}}};
  GetNodeModifiers()->getCommonMethodModifier()->setBackgroundBlurStyle((Ark_NativePointer)0x123, var137_0, &var138_0);
  const DragPreviewOptions var249_0 = {{ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_OBJECT, {1, .value1={102, .i32=10}}}};
  const Opt_DragInteractionOptions var250_0 = {ARK_TAG_OBJECT, {{ARK_TAG_OBJECT, true}, {ARK_TAG_UNDEFINED, {}}}};
  GetNodeModifiers()->getCommonMethodModifier()->setDragPreviewOptions((Ark_NativePointer)0x123, &var249_0, &var250_0);
  const DragPreviewOptions var249_1 = {{ARK_TAG_UNDEFINED, {}}, {ARK_TAG_UNDEFINED, {}}, {ARK_TAG_OBJECT, {0, .value0=true}}};
  const Opt_DragInteractionOptions var250_1 = {ARK_TAG_OBJECT, {{ARK_TAG_UNDEFINED, {}}, {ARK_TAG_OBJECT, false}}};
  GetNodeModifiers()->getCommonMethodModifier()->setDragPreviewOptions((Ark_NativePointer)0x123, &var249_1, &var250_1);
  const Ark_Number var1383_0 = {102, .i32=11};
  GetNodeModifiers()->getSideBarContainerModifier()->setMinSideBarWidth_number((Ark_NativePointer)0x123, &var1383_0);
  const Ark_Length var1386_0 = {1, 42.000000, 3, 0};
  GetNodeModifiers()->getSideBarContainerModifier()->setMinSideBarWidth_Length((Ark_NativePointer)0x123, &var1386_0);
  const Type_NavigationAttribute_backButtonIcon_Arg0 var628_0 = {0, .value0={"attr", 4}};
  GetNodeModifiers()->getNavigationModifier()->setBackButtonIcon((Ark_NativePointer)0x123, &var628_0);

  return 0;
}