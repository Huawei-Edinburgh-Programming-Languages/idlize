#include "arkoala_api_generated.h"
#include <string>

#ifndef LIBRARY_STUB_H
#define LIBRARY_STUB_H

enum ArkUIAPIVariantKind {
    BASIC = 0,
    FULL = 1,
    GRAPHICS = 2,
    EXTENDED = 3,
    COUNT = EXTENDED + 1
};

typedef struct ArkUIAnyAPI {
    Ark_Int32 version;
} ArkUIAnyAPI;

const ArkUIAnyAPI* GetAnyImpl(ArkUIAPIVariantKind kind, int version, std::string* result = nullptr);

#endif