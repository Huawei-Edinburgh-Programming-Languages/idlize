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
#include "Serializers.h"
#include "arkoala-logging.h"
#include "common-interop.h"
#include "arkoala-macros.h"

typedef void (*AppendGroupedLogSignature)(int32_t, const std::string&);

AppendGroupedLogSignature appendGroupedLogPtr = nullptr;

void SetAppendGroupedLog(void* logger) {
    if (logger) appendGroupedLogPtr = reinterpret_cast<AppendGroupedLogSignature>(logger);
}

void dummyClassFinalizer(KNativePointer* ptr) {
    char hex[20];
    std::snprintf(hex, sizeof(hex), "0x%llx", (long long)ptr);
    string out("dummyClassFinalizer(");
    out.append(hex);
    out.append(")");
    appendGroupedLog(1, out);
}

namespace OHOS::Ace::NG {
Ark_NodeHandle CreateNode(GENERATED_Ark_NodeType type, Ark_Int32 id, Ark_Int32 flags) {
    Ark_NodeHandle result = (Ark_NodeHandle) 123;
    if (!needGroupedLog(1)) {
        return result;
    }
    string out("createNode(");
    WriteToString(&out, (Ark_Int32)type);
    out.append(", ");
    WriteToString(&out, id);
    out.append(", ");
    WriteToString(&out, flags);
    out.append(")");
    appendGroupedLog(1, out);
    return result;
}
namespace ApiImpl {
Ark_NodeHandle GetNodeByViewStack() {
    Ark_NodeHandle result = (Ark_NodeHandle) 234;
    if (!needGroupedLog(1)) {
        return result;
    }
    string out("getNodeByViewStack()");
    appendGroupedLog(1, out);
    return result;
}

void DisposeNode(Ark_NodeHandle node) {
    if (!needGroupedLog(1)) {
        return;
    }

    string out("disposeNode(");
    WriteToString(&out, node);
    out.append(")");
    appendGroupedLog(1, out);
}

Ark_Int32 AddChild(Ark_NodeHandle parent, Ark_NodeHandle child) {
    // TODO: implement test
    return 0; // ERROR_CODE_NO_ERROR
}

void RemoveChild(Ark_NodeHandle parent, Ark_NodeHandle child) {
// TODO: implement test
}

Ark_Int32 InsertChildAfter(Ark_NodeHandle parent, Ark_NodeHandle child, Ark_NodeHandle sibling) {
    return 0; // TODO: implement test
}

Ark_Int32 InsertChildBefore(Ark_NodeHandle parent, Ark_NodeHandle child, Ark_NodeHandle sibling) {
    return 0; // TODO: implement test
}

Ark_Int32 InsertChildAt(Ark_NodeHandle parent, Ark_NodeHandle child, Ark_Int32 position) {
    return 0; // TODO: implement test
}

void ApplyModifierFinish(Ark_NodeHandle node) {
// TODO: implement test
}

void MarkDirty(Ark_NodeHandle node, Ark_UInt32 flag) {
// TODO: implement test
}

Ark_Boolean IsBuilderNode(Ark_NodeHandle node) {
    return 0; // TODO: implement test
}

Ark_Float32 ConvertLengthMetricsUnit(Ark_Float32 value, Ark_Int32 originUnit, Ark_Int32 targetUnit) {
    return 0.0f; // TODO: implement test
}
}
}
