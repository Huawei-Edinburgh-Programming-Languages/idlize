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

#ifndef SKOALA_DESERIALIZER_BASE_H 
#define SKOALA_DESERIALIZER_BASE_H 

#include <stdint.h>
#include <cassert>
#include <cstring>
#include <string>
#include <vector>

struct Skoala_Paint {
    bool isAntiAlias;           // Anti-aliasing flag
    bool isDither;              // Dither flag
    uint32_t color;             // Color stored as an integer (32-bit)
    float color4f[4];           // RGBA values for color
    uint32_t alpha;             // Alpha transparency (0-255)
    uint32_t mode;              // Mode (assuming it's some kind of enumerator)
    float strokeWidth;          // Stroke width for painting
    float strokeMiter;          // Stroke miter limit
    uint32_t strokeCap;         // Stroke cap style (assuming an enumerator)
    uint32_t strokeJoin;        // Stroke join style (assuming an enumerator)
    Skoala_NativePointer maskFilter;   // Mask filter pointer
    Skoala_NativePointer imageFilter;  // Image filter pointer
    uint32_t blendMode;         // Blend mode (assuming it's an enumerator)
    Skoala_NativePointer blender;      // Blender pointer
    Skoala_NativePointer pathEffect;   // Path effect pointer
    Skoala_NativePointer shader;       // Shader pointer
    Skoala_NativePointer colorFilter;  // Color filter pointer
    bool hasNothingToDraw;      // Flag indicating if there's nothing to draw
};

struct Skoala_Rect {
    void* coordinates;
    float left;
    float top;
    float right;
    float bottom;
    float width;
    float height;
    bool isEmpty;
};

struct Skoala_RRect {
    void* radii;
};

struct Skoala_Canvas {
    float xscale;
    float yscale;
    int32_t saveCount;
};

typedef bool Skoala_Boolean;
typedef int32_t Skoala_Int32;
typedef float Skoala_Float32;
typedef char* Skoala_String;
typedef void* Skoala_NativePointer;

struct Skoala_Length {
    int32_t unit;
    int32_t type;
    int32_t resource;
    float value;
};

class SkoalaDeserializerBase
{
protected:
    uint8_t *data;
    int32_t length;
    int32_t position;
    std::vector<void *> toClean;

public:
    SkoalaDeserializerBase(uint8_t *data, int32_t length)
        : data(data), length(length), position(0) {}

    ~SkoalaDeserializerBase()
    {
        for (auto data : toClean)
        {
            free(data);
        }
    }

    template <typename T, typename E>
    void resizeArray(T *array, int32_t length)
    {
        void *value = nullptr;
        if (length > 0)
        {
            value = malloc(length * sizeof(E));
            memset(value, 0, length * sizeof(E));
            toClean.push_back(value);
        }
        array->length = length;
        array->array = reinterpret_cast<E *>(value);
    }

    void check(int32_t count)
    {
        if (position + count > length)
        {
            assert(false);
        }
    }

    Skoala_Boolean readSkoala_Boolean()
    {
        check(1);
        int8_t value = *(data + position);
        position += 1;
        return value != 0;
    }

    Skoala_Int32 readSkoala_Int32()
    {
        check(4);
        Skoala_Int32 value = *(Skoala_Int32 *)(data + position);
        position += 4;
        return value;
    }

    Skoala_Float32 readSkoala_Float32()
    {
        check(4);
        Skoala_Float32 value = *(Skoala_Float32 *)(data + position);
        position += 4;
        return value;
    }

    Skoala_NativePointer readPointer()
    {
        check(8);
        int64_t value = *(int64_t *)(data + position);
        position += 8;
        return reinterpret_cast<Skoala_NativePointer>(value);
    }

    void* readFloat32Array()
    {
        int32_t arrayLength = readSkoala_Int32();
        check(arrayLength * sizeof(Skoala_Float32));
        void* array = malloc(arrayLength * sizeof(Skoala_Float32));
        memcpy(array, data + position, arrayLength * sizeof(Skoala_Float32));
        position += arrayLength * sizeof(Skoala_Float32);
        toClean.push_back(array);
        return array;
    }

};

#endif 