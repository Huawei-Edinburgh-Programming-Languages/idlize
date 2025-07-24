#include "test_fqn.h"
#include "DeserializerBase.h"
#include <iostream>

void GlobalScope_resizeImpl(const OH_TEST_FQN_Rectangle* arg) {
    std::string numWidth, numHeight;
    WriteToString(&numWidth, arg->numSize.width);
    WriteToString(&numHeight, arg->numSize.height);
    std::cout << "resize(numSize=" << numWidth << "x" << numHeight
              << ", intSize=" << arg->intSize.width << "x" << arg->intSize.height
              << ", floatSize=" << arg->floatSize.width << "x" << arg->floatSize.height
              << ")" << std::endl;
}
