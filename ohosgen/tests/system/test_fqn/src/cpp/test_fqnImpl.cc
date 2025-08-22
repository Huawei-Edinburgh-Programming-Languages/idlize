#include "test_fqn.h"
#include "DeserializerBase.h"
#include <iostream>

void GlobalScope_resizeImpl(const OH_TEST_FQN_Sizes* arg) {
    // std::string numWidth, numHeight;
    // WriteToString(&numWidth, arg->numSize.numWidth);
    // WriteToString(&numHeight, arg->numSize.numHeight);
    std::cout ///<< "resize(numSize=" << numWidth << "x" << numHeight
              << ", intSize=" << arg->intSize.intWidth << "x" << arg->intSize.intHeight
              << ", floatSize=" << arg->floatSize.floatWidth << "x" << arg->floatSize.floatHeight
              << ")" << std::endl;
}

void GlobalScope_resize3Impl(const OH_TEST_FQN_Size* numSize, const OH_TEST_FQN_Size* intSize, const OH_TEST_FQN_fp_Size* floatSize) {
    std::cout ///<< "resize(numSize=" << numSize->numWidth << "x" << numSize->numHeight
        << ", intSize=" << intSize->intWidth << "x" << intSize->intHeight
        << ", floatSize=" << floatSize->floatWidth << "x" << floatSize->floatHeight
        << ")" << std::endl;
}
