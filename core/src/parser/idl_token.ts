
export enum Token {
  // regexp
  tInteger = 1,
  tDecimal = 2,
  tId = 3,
  tString = 4,
  tComment = 5,
  tLongComment = 6,
  tWhiteSpace = 7,

  // marks
  tEqual = 10,        // =
  tLBracket = 11,     // (
  tRBracket = 12,     // )
  tLBrace = 13,       // {
  tRBrace = 14,       // }
  tLAngle = 15,       // <
  tRAngle = 16,       // >
  tLSqrBracket = 17,  // [
  tRSqrBracket = 18,  // ]
  tColon = 19,        // :
  tSemicolon = 20,    // ;
  tDot = 21,          // .
  tComma = 22,        // ,
  tPlus = 23,         // +
  tMinus = 24,        // -
  tAsterisk = 25,     // *
  tEllipsis = 26,     // ...
  tQuestion = 27,     // ?
  tDiv = 28,          // /

  // ArgumentNameKeywords
  tAsync = 30,
  tAttribute = 31,
  tCallback = 32,
  tClass = 33,
  tConst = 34,
  tConstructor = 35,
  tDictionary = 37,
  tInterface = 42,
  tNamespace = 46,
  tPackage = 47,
  tPartial = 48,
  tReadonly = 49,
  tStatic = 53,
  tTypedef = 55,
  tUnrestricted = 56,

  // keywords
  tShort = 60,        // short
  tLong = 61,         // long
  tUnsigned = 62,     // unsigned
  tBoolean = 63,
  tByte = 64,
  tOctet = 65,
  tBigint = 66,
  tFloat = 67,        // float
  tDouble = 68,       // double
  tOr = 69,           // or
  tStringType = 70,   // string type with name String
  tVoid = 74,
  tAny = 75,          // The any type is the union of all other possible non-union types.
  tUndefined = 76,
  tSequence = 77,
  tFrozenArray = 78,
  tObservableArray = 79,
  tRecord = 80,
  tObject = 81,       // I found this two types in standard but not in source code
  tSymbol = 82,
  tOptional = 83,
  tNull = 84,

  tArrayBuffer = 90,
  tSharedArrayBuffer = 91,
  tDataView = 92,
  tInt8Array = 93,
  tInt16Array = 94,
  tInt32Array = 95,
  tUint8Array = 96,
  tUint16Array = 97,
  tUint32Array = 98,
  tUint8ClampedArray = 99,
  tBigInt64Array = 100,
  tBigUint64Array = 101,
  tFloat16Array = 102,
  tFloat32Array = 103,
  tFloat64Array = 104,

  tPromise = 105,
  tNumber = 106,
  tMinusInfinity = 107,
  tPlusInfinity = 108,
  tNaN = 109,

  tTrue = 110,
  tFalse = 111,

  tError = 1000,
  tEnd = 1001,
};
