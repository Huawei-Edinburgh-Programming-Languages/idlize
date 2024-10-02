#include <stdint.h>
/* clang-format off */

#ifdef __cplusplus
extern "C" {
#endif

enum Ark_Tag
{
  ARK_TAG_UNDEFINED = 101,
  ARK_TAG_INT32 = 102,
  ARK_TAG_FLOAT32 = 103,
  ARK_TAG_STRING = 104,
  ARK_TAG_LENGTH = 105,
  ARK_TAG_RESOURCE = 106,
  ARK_TAG_OBJECT = 107,
};

enum Ark_RuntimeType
{
  ARK_RUNTIME_UNEXPECTED = -1,
  ARK_RUNTIME_NUMBER = 1,
  ARK_RUNTIME_STRING = 2,
  ARK_RUNTIME_OBJECT = 3,
  ARK_RUNTIME_BOOLEAN = 4,
  ARK_RUNTIME_UNDEFINED = 5,
  ARK_RUNTIME_BIGINT = 6,
  ARK_RUNTIME_FUNCTION = 7,
  ARK_RUNTIME_SYMBOL = 8,
  ARK_RUNTIME_MATERIALIZED = 9,
};

typedef float Ark_Float32;
typedef double Ark_Float64;
typedef int32_t Ark_Int32;
typedef unsigned int Ark_UInt32; // TODO: update unsigned int
typedef int64_t Ark_Int64;
typedef int8_t Ark_Int8;
typedef int8_t Ark_Boolean;
typedef const char* Ark_CharPtr;
typedef void* Ark_NativePointer;

