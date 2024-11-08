#ifndef KOALA_UI_LIBRARY_H
#define KOALA_UI_LIBRARY_H

#include "arkoala_api_generated.h"
#include <string>

const %CPP_PREFIX%ArkUIAnyAPI* GetAnyImpl(int kind, int version, std::string* result);

#endif //KOALA_UI_LIBRARY_H