#include "test_name_collision.h"
#include <iostream>

void GlobalScope_resizeImpl(const OH_TEST_NAME_COLLISION_Size* size) {
    std::cout << "resizeImpl(" << size->height << "x" << size->width << ")" << std::endl;
}
void GlobalScope_test_testSizeImpl(const OH_TEST_NAME_COLLISION_test_Size* size) {
    std::cout << "testSizeImpl(" << size->spec.chars << ")" << std::endl;
}
