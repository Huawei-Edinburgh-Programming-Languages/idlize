#include "common-interop.h"

void impl_CallCallback(int32_t kind, uint8_t* thisArray, int32_t thisLength) {
    return;
}
KOALA_INTEROP_V3(CallCallback, KInt, KByte*, KInt)

void impl_CallCallbackResourceHolder(int32_t kind, uint8_t* thisArray, int32_t resourceId) {
    return;
}
KOALA_INTEROP_V3(CallCallbackResourceHolder, KInt, KByte*, KInt)

void impl_CallCallbackResourceReleaser(int32_t kind, uint8_t* thisArray, int32_t resourceId) {
    return;
}
KOALA_INTEROP_V3(CallCallbackResourceReleaser, KInt, KByte*, KInt)
