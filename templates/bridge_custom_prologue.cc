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
#include "library.h"
#include "common-interop.h"
#include "arkoala_api_generated.h"
#include "Serializers.h"
#include "arkoala-logging.h"

const %CPP_PREFIX%ArkUIBasicNodeAPI* GetArkUIBasicNodeAPI() {
    return reinterpret_cast<const %CPP_PREFIX%ArkUIBasicNodeAPI*>(
        GetAnyImpl(static_cast<ArkUIAPIVariantKind>(%CPP_PREFIX%Ark_APIVariantKind::%CPP_PREFIX%BASIC), 
        %CPP_PREFIX%ARKUI_BASIC_NODE_API_VERSION));
}

const %CPP_PREFIX%ArkUIExtendedNodeAPI* GetArkUIExtendedNodeAPI() {
    return reinterpret_cast<const %CPP_PREFIX%ArkUIExtendedNodeAPI*>(
        GetAnyImpl(static_cast<ArkUIAPIVariantKind>(%CPP_PREFIX%Ark_APIVariantKind::%CPP_PREFIX%EXTENDED), 
        %CPP_PREFIX%ARKUI_EXTENDED_NODE_API_VERSION));
}


// set delay API

namespace TreeNodeDelays {
    void SetCreateNodeDelay(GENERATED_Ark_NodeType type, Ark_Int64 nanoseconds);
    void SetMeasureNodeDelay(GENERATED_Ark_NodeType type, Ark_Int64 nanoseconds);
    void SetLayoutNodeDelay(GENERATED_Ark_NodeType type, Ark_Int64 nanoseconds);
    void SetDrawNodeDelay(GENERATED_Ark_NodeType type, Ark_Int64 nanoseconds);
}

void impl_SetCreateNodeDelay(Ark_Int32 type, Ark_Int64 nanoseconds) {
    GENERATED_Ark_NodeType typeCast = GENERATED_Ark_NodeType(type);
    TreeNodeDelays::SetCreateNodeDelay(typeCast, nanoseconds);
}
KOALA_INTEROP_V2(SetCreateNodeDelay, Ark_Int32, Ark_Int64)

void impl_SetMeasureNodeDelay(Ark_Int32 type, Ark_Int64 nanoseconds) {
    GENERATED_Ark_NodeType typeCast = GENERATED_Ark_NodeType(type);
    TreeNodeDelays::SetMeasureNodeDelay(typeCast, nanoseconds);
}
KOALA_INTEROP_V2(SetMeasureNodeDelay, Ark_Int32, Ark_Int64)

void impl_SetLayoutNodeDelay(Ark_Int32 type, Ark_Int64 nanoseconds) {
    GENERATED_Ark_NodeType typeCast = GENERATED_Ark_NodeType(type);
    TreeNodeDelays::SetLayoutNodeDelay(typeCast, nanoseconds);
}
KOALA_INTEROP_V2(SetLayoutNodeDelay, Ark_Int32, Ark_Int64)

void impl_SetDrawNodeDelay(Ark_Int32 type, Ark_Int64 nanoseconds) {
    GENERATED_Ark_NodeType typeCast = GENERATED_Ark_NodeType(type);
    TreeNodeDelays::SetDrawNodeDelay(typeCast, nanoseconds);
}
KOALA_INTEROP_V2(SetDrawNodeDelay, Ark_Int32, Ark_Int64)


// custom methods

void impl_ShowCrash(const KStringPtr& messagePtr) {
    GetArkUIExtendedNodeAPI()->showCrash(messagePtr.c_str());
}
KOALA_INTEROP_V1(ShowCrash, KStringPtr)

Ark_Int32 impl_LayoutNode(KVMContext vmContext, Ark_NativePointer nodePtr, KFloatArray data) {
    return GetArkUIExtendedNodeAPI()->layoutNode((Ark_VMContext)vmContext, (Ark_NodeHandle)nodePtr, (Ark_Float32(*)[2])data);
}
KOALA_INTEROP_CTX_2(LayoutNode, Ark_Int32, Ark_NativePointer, KFloatArray)

void impl_EmulateClickEvent(KInt nodeId, KFloat x, KFloat y) {
    Ark_ClickEvent event;
    event.target.area.width.type = 0;
    event.target.area.width.value = 0;
    event.target.area.width.unit = 1;
    event.target.area.width.resource = 0;
    event.target.area.height.type = 0;
    event.target.area.height.value = 0;
    event.target.area.height.unit = 1;
    event.target.area.height.resource = 0;
    event.target.area.position.x.tag = ARK_TAG_UNDEFINED;
    event.target.area.position.y.tag = ARK_TAG_UNDEFINED;
    event.target.area.globalPosition.x.tag = ARK_TAG_UNDEFINED;
    event.target.area.globalPosition.y.tag = ARK_TAG_UNDEFINED;
    event.timestamp.tag = ARK_TAG_INT32;
    event.timestamp.i32 = 100;
    event.source = ARK_SOURCE_TYPE_MOUSE;
    event.axisHorizontal.tag = ARK_TAG_UNDEFINED;
    event.axisVertical.tag = ARK_TAG_UNDEFINED;
    event.pressure.tag = ARK_TAG_FLOAT32;
    event.pressure.f32 = 0.0f;
    event.tiltX.tag = ARK_TAG_FLOAT32;
    event.tiltX.f32 = 0.0f;
    event.tiltY.tag = ARK_TAG_FLOAT32;
    event.tiltY.f32 = 0.0f;
    event.sourceTool = ARK_SOURCE_TOOL_MOUSE;
    event.deviceId.value.tag = ARK_TAG_INT32;
    event.deviceId.value.i32 = 0;
    event.displayX.tag = ARK_TAG_FLOAT32;
    event.displayX.f32 = 0.0f;
    event.displayY.tag = ARK_TAG_FLOAT32;
    event.displayY.f32 = 0.0f;
    event.windowX.tag = ARK_TAG_FLOAT32;
    event.windowX.f32 = 0.0f;
    event.windowY.tag = ARK_TAG_FLOAT32;
    event.windowY.f32 = 0.0f;
    event.screenX.tag = ARK_TAG_FLOAT32;
    event.screenX.f32 = 0.0f;
    event.screenY.tag = ARK_TAG_FLOAT32;
    event.screenY.f32 = 0.0f;
    event.x.tag = ARK_TAG_FLOAT32;
    event.x.f32 = x;
    event.y.tag = ARK_TAG_FLOAT32;
    event.y.f32 = y;
    event.preventDefault.resource.resourceId = 0;
    event.preventDefault.resource.hold = [](KInt id){};
    event.preventDefault.resource.release = [](KInt id){};
    event.preventDefault.call = [](KInt id){};

    GetFullImpl()->getEventsAPI()->getLocationButtonEventsReceiver()->onClick(nodeId, event, ARK_LOCATION_BUTTON_ON_CLICK_RESULT_SUCCESS);
}
KOALA_INTEROP_V3(EmulateClickEvent, KInt, KFloat, KFloat)

void impl_EmulateTextInputEvent(KInt nodeId, const KStringPtr& text) {
    std::string value = getString(text);
    Ark_String str {
        .chars = value.c_str(),
        .length = static_cast<Ark_Int32>(value.length())
    };
    Opt_PreviewText preview;
    preview.tag = ARK_TAG_UNDEFINED;
    GetFullImpl()->getEventsAPI()->getTextInputEventsReceiver()->onChange(nodeId, str, preview);
}
KOALA_INTEROP_V2(EmulateTextInputEvent, KInt, KStringPtr)
