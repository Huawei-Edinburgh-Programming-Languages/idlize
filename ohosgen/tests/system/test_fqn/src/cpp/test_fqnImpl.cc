#include "test_fqn.h"
#include "DeserializerBase.h"
#include <iostream>

void GlobalScope_resizeImpl(const OH_TEST_FQN_Rectangle* arg) {
    std::cout << "resize(size=" << arg->size.height << "x" << arg->size.width <<
                      ", offset=" << arg->offset.x << "," << arg->offset.y << ")" << std::endl;
}
