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

#ifndef DESERIALIZER_H
#define DESERIALIZER_H

#include "SkoalaDeserializerBase.h"

class Deserializer : public SkoalaDeserializerBase {
public:
    Deserializer(uint8_t* data, int32_t length) : SkoalaDeserializerBase(data, length) {}

    Skoala_Paint readPaint() {
        Skoala_Paint value = {};
        return value;
    }

    Skoala_Rect readRect() {
        Skoala_Rect value = {};
        value.coordinates = this->readFloat32Array();
        value.left = this->readFloat32();
        value.top = this->readFloat32();
        value.right = this->readFloat32();
        value.bottom = this->readFloat32();
        value.width = this->readFloat32();
        value.height = this->readFloat32();
        value.isEmpty = this->readBoolean();
        return value;
    }

    Skoala_RRect readRRect() {
        Skoala_RRect value = {};
        value.radii = this->readFloat32Array();
        return value;
    }

};

#endif