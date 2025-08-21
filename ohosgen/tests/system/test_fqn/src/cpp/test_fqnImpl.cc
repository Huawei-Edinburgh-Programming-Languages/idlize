#include "test_fqn.h"
#include "DeserializerBase.h"
#include <iostream>

void GlobalScope_resizeImpl(const OH_TEST_FQN_Sizes* arg) {
    std::string numWidth, numHeight;
    WriteToString(&numWidth, arg->numSize.numWidth);
    WriteToString(&numHeight, arg->numSize.numHeight);
    std::cout << "resize(numSize=" << numWidth << "x" << numHeight
              << ", intSize=" << arg->intSize.intWidth << "x" << arg->intSize.intHeight
              << ", floatSize=" << arg->floatSize.floatWidth << "x" << arg->floatSize.floatHeight
              << ")" << std::endl;
}
