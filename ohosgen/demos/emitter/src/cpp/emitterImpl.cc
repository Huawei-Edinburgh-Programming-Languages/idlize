#include "common-interop.h"
#include "emitter.h"

void GlobalScope_emitter_emit0Impl(const OH_EMITTER_InnerEvent* event, const Opt_EventData* data) {
    printf("GlobalScope_emitter_emit0Impl\n");
}

void GlobalScope_emitter_emit1Impl(const OH_String* eventId, const Opt_EventData* data) {
    printf("GlobalScope_emitter_emit1Impl\n");
}

void GlobalScope_emitter_emit2Impl(const OH_String* eventId, const OH_EMITTER_Options* options, const Opt_EventData* data) {
    printf("GlobalScope_emitter_emit2Impl\n");
}