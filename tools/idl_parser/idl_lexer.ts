
const BooleanLiteral: readonly string[] = [ "true", "false" ]

const FloatLiteral: readonly string[] = [ "decimal", "-Infinity", "Infinity", "NaN" ]

export enum Token {
  // regexp
  tInteger = 1,
  tDecimal = 2,
  tId = 3,
  tString = 4,
  tComment = 5,
  tWhiteSpace = 6,

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
  tDeleter = 36,
  tDictionary = 37,
  tEnum = 38,
  tGetter = 39,
  tIncludes = 40,
  tInherit = 41,
  tInterface = 42,
  tIterable = 43,
  tMaplike = 44,
  tMixin = 45,
  tNamespace = 46,
  tPackage = 47,
  tPartial = 48,
  tReadonly = 49,
  tRequired = 50,
  tSetlike = 51,
  tSetter = 52,
  tStatic = 53,
  tStringifier = 54,
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
  tByteString = 71,   // strings
  tDOMString = 72,
  tUSVString = 73,
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

  tError = 1000,
  tEnd = 1001,
};

type TokenPattern = {
  pattern: RegExp;
  type: Token;
};

const g_keywords: Array<TokenPattern> = [
  // regexp
  { pattern: /-?([1-9][0-9]*|0[Xx][0-9A-Fa-f]+|0[0-7]*)/, type: Token.tInteger},
  { pattern: /-?(([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)([Ee][+-]?[0-9]+)?|[0-9]+[Ee][+-]?[0-9]+)/, type: Token.tDecimal},
  { pattern: /[_-]?[A-Za-z][0-9A-Z_a-z-]*/, type: Token.tId},
  { pattern: /"[^"]*"/, type: Token.tString},
  { pattern: /\/\/.*|\/\*(.|\n)*?\*\//, type: Token.tComment},
  { pattern: /[\t\n\r ]+/, type: Token.tWhiteSpace},

  // marks
  { pattern: /=/, type: Token.tEqual },
  { pattern: /\(/, type: Token.tLBracket },
  { pattern: /\)/, type: Token.tRBracket },
  { pattern: /\{/, type: Token.tLBrace },
  { pattern: /\}/, type: Token.tRBrace },
  { pattern: /\</, type: Token.tLAngle },
  { pattern: /\>/, type: Token.tRAngle },
  { pattern: /\[/, type: Token.tLSqrBracket },
  { pattern: /\]/, type: Token.tRSqrBracket },
  { pattern: /\:/, type: Token.tColon },
  { pattern: /\;/, type: Token.tSemicolon },
  { pattern: /\./, type: Token.tDot },
  { pattern: /\,/, type: Token.tComma },
  { pattern: /\+/, type: Token.tPlus },
  { pattern: /\-/, type: Token.tMinus },
  { pattern: /\*/, type: Token.tAsterisk },
  { pattern: /\.\.\./, type: Token.tEllipsis },
  { pattern: /\?/, type: Token.tQuestion },
  { pattern: /\//, type: Token.tDiv },

  // ArgumentNameKeywords
  { pattern: /async/, type: Token.tAsync},
  { pattern: /attribute/, type: Token.tAttribute},
  { pattern: /callback/, type: Token.tCallback},
  { pattern: /class/, type: Token.tClass},
  { pattern: /const/, type: Token.tConst},
  { pattern: /constructor/, type: Token.tConstructor},
  { pattern: /deleter/, type: Token.tDeleter},
  { pattern: /dictionary/, type: Token.tDictionary},
  { pattern: /enum/, type: Token.tEnum},
  { pattern: /getter/, type: Token.tGetter},
  { pattern: /includes/,  type: Token.tIncludes},
  { pattern: /inherit/, type: Token.tInherit},
  { pattern: /interface/, type: Token.tInterface},
  { pattern: /iterable/, type: Token.tIterable},
  { pattern: /maplike/, type: Token.tMaplike},
  { pattern: /mixin/,  type: Token.tMixin},
  { pattern: /namespace/, type: Token.tNamespace},
  { pattern: /package/, type: Token.tPackage},
  { pattern: /partial/, type: Token.tPartial},
  { pattern: /readonly/, type: Token.tReadonly},
  { pattern: /required/, type: Token.tRequired},
  { pattern: /setlike/, type: Token.tSetlike},
  { pattern: /setter/, type: Token.tSetter},
  { pattern: /static/, type: Token.tStatic},
  { pattern: /stringifier/, type: Token.tStringifier},
  { pattern: /typedef/, type: Token.tTypedef},
  { pattern: /unrestricted/, type: Token.tUnrestricted},

  // Other tokens
  { pattern: /short/, type: Token.tShort},
  { pattern: /long/, type: Token.tLong},
  { pattern: /unsigned/, type: Token.tUnsigned},
  { pattern: /boolean/, type: Token.tBoolean},
  { pattern: /byte/, type: Token.tByte},
  { pattern: /octet/, type: Token.tOctet},
  { pattern: /bigint/, type: Token.tBigint},
  { pattern: /float/, type: Token.tFloat},
  { pattern: /double/, type: Token.tDouble},
  { pattern: /or/, type: Token.tOr},
  { pattern: /String/, type: Token.tString},
  { pattern: /ByteString/, type: Token.tByteString},
  { pattern: /DOMString/, type: Token.tDOMString},
  { pattern: /USVString/, type: Token.tUSVString},
  { pattern: /void/, type: Token.tVoid},  // void type is replaced by undefined type
                          // (c) https://github.com/w3c/webidl2.js?tab=readme-ov-file#errors
  { pattern: /any/, type: Token.tAny},
  { pattern: /undefined/, type: Token.tUndefined},
  { pattern: /sequence/, type: Token.tSequence},
  { pattern: /FrozenArray/, type: Token.tFrozenArray},
  { pattern: /ObservableArray/, type: Token.tObservableArray},
  { pattern: /record/, type: Token.tRecord},
  { pattern: /object/, type: Token.tObject},
  { pattern: /symbol/, type: Token.tSymbol},
  { pattern: /optional/, type: Token.tOptional},

  { pattern: /ArrayBuffer/, type: Token.tArrayBuffer},
  { pattern: /SharedArrayBuffer/, type: Token.tSharedArrayBuffer},
  { pattern: /DataView/, type: Token.tDataView},
  { pattern: /Int8Array/, type: Token.tInt8Array},
  { pattern: /Int16Array/, type: Token.tInt16Array},
  { pattern: /Int32Array/, type: Token.tInt32Array},
  { pattern: /Uint8Array/, type: Token.tUint8Array},
  { pattern: /Uint16Array/, type: Token.tUint16Array},
  { pattern: /Uint32Array/, type: Token.tUint32Array},
  { pattern: /Uint8ClampedArray/, type: Token.tUint8ClampedArray},
  { pattern: /BigInt64Array/, type: Token.tBigInt64Array},
  { pattern: /BigUint64Array/, type: Token.tBigUint64Array},
  { pattern: /Float16Array/, type: Token.tFloat16Array},
  { pattern: /Float32Array/, type: Token.tFloat32Array},
  { pattern: /Float64Array/, type: Token.tFloat64Array},

  { pattern: /Promise/, type: Token.tPromise},
  { pattern: /number/, type: Token.tNumber},
];

let g_ArgumentNameKeyword: Token[] = [
  Token.tAsync, Token.tAttribute, Token.tCallback, Token.tConst, Token.tConstructor,
  Token.tDeleter, Token.tDictionary, Token.tEnum, Token.tGetter, Token.tIncludes,
  Token.tInherit, Token.tInterface, Token.tIterable, Token.tMaplike, Token.tMixin,
  Token.tNamespace, Token.tPartial, Token.tReadonly, Token.tRequired, Token.tSetlike,
  Token.tSetter, Token.tStatic, Token.tStringifier, Token.tTypedef, Token.tUnrestricted
];

export function IsItArgumentNameKeyword(value: Token): boolean {
  return g_ArgumentNameKeyword.includes(value);
}

export function IsItSingleType(value: Token): boolean {
  return IsItDistinguishableType(value) ||
         value == Token.tAny ||
         value == Token.tPromise;
}

export function IsItDistinguishableType(value: Token): boolean {
  return IsItPrimitiveType(value) ||
         IsItStringType(value) ||
         value == Token.tId ||
         value == Token.tSequence ||
         value == Token.tAsync ||
         value == Token.tObject ||
         value == Token.tSymbol ||
         IsItBufferRelatedType(value) ||
         value == Token.tFrozenArray ||
         value == Token.tObservableArray ||
         value == Token.tRecord ||
         value == Token.tUndefined;
}

// Just a part of primitive types...
let g_PrimitiveType: Token[] = [
  Token.tBoolean, Token.tByte, Token.tOctet, Token.tBigint
];

export function IsItPrimitiveType(value: Token): boolean {
  return IsItUnsignedIntegerType(value) ||
         IsItUnrestrictedFloatType(value) ||
         g_PrimitiveType.includes(value) ||
         value == Token.tVoid;
}

export function IsItUnsignedIntegerType(value: Token): boolean {
  return value == Token.tUnsigned || IsItIntegerType(value);
}

export function IsItIntegerType(value: Token): boolean {
  return value == Token.tShort || value == Token.tLong;
}

export function IsItUnrestrictedFloatType(value: Token): boolean {
  return value == Token.tUnrestricted || IsItFloatType(value);
}

export function IsItFloatType(value: Token): boolean {
  return value == Token.tFloat || value == Token.tDouble;
}

let g_StringType: Token[] = [
  Token.tByteString, Token.tDOMString, Token.tUSVString
];

export function IsItStringType(value: Token): boolean {
  return g_StringType.includes(value);
}

let g_BufferRelatedType: Token[] = [
  Token.tArrayBuffer, Token.tSharedArrayBuffer, Token.tDataView,
  Token.tInt8Array, Token.tInt16Array, Token.tInt32Array,
  Token.tUint8Array, Token.tUint16Array, Token.tUint32Array,
  Token.tUint8ClampedArray, Token.tBigInt64Array, Token.tBigUint64Array,
  Token.tFloat16Array, Token.tFloat32Array, Token.tFloat64Array
];

export function IsItBufferRelatedType(value: Token): boolean {
  return g_BufferRelatedType.includes(value);
}

let g_Types: Token[] = [
  Token.tShort, Token.tLong, Token.tUnsigned, Token.tBoolean,
  Token.tByte, Token.tOctet, Token.tBigint, Token.tFloat, Token.tDouble,
  Token.tString, Token.tVoid, Token.tNumber
]

let g_lastId = 0;
let g_words = new Map<string, number>([
//  ["word", id]
]);

function getWord(word: string): number {
  const has = g_words.has(word);
  if (!has)
    return -1;

  const val = g_words.get(word);
  if (val !== undefined)
    return +val;
  else
    return -1;
}

function addWord(word: string): number {
  g_lastId++;
  g_words.set(word, g_lastId);
  return g_lastId;
}

let g_text: string;
let g_pos: number = 0;
let g_col: number = 0;
let g_row: number = 0;
let g_tokenText: string = "";
let g_lineStartPos = 0;
let prev: string = ' ';  // TypeScript does not support static in functions :(

export function init(text: string) {
  g_text = text + '\n';  // Some files have no EOL in the end, so we fix it here!
  g_pos = 0;
  g_col = 0;
  g_row = 0;
  g_tokenText = "";
  g_lineStartPos = 0;
}

function isLetter(c: string): boolean {
  return ((c >= 'a' && c <= 'z') ||
          (c >= 'A' && c <= 'Z') ||
          (c == '_' || c == '$'));
}

function isDigit(c: string): boolean {
  return (c >= '0' && c <= '9');
}

function getChar(): string {
  if (g_pos >= g_text.length)
    return '\0';
  else
    return g_text[g_pos++];
}

function returnChar() {
  if (g_pos > 0) {
    g_pos--;
    if (g_pos > 0)
      prev = g_text[g_pos - 1];
    else
      prev = ' ';
  } else {
    throw new Error("Can't decrement g_pos cause it's zero.");
  }
}

export function getTokenText(): string {
  return g_tokenText;
}

export function getToken(): Token {
  console.log("getToken <<<");
  let t: Token = getTokenInternal();
  while (t == Token.tNeedRepeat) {
    console.log("tNeedRepeat found, g_pos = ", g_pos);
    t = getTokenInternal();
  }

  console.log(t);

  return t;
}

function getTokenInternal(): Token {
  let c: string = getChar();
  if (c == '\0') {
    console.log(" return tEnd");
    return Token.tEnd;
  }

  // Linux EOL:   0A    LF \n
  // Windows EOL: 0D 0A CR LF \r\n
  // Mac:         0D ?  CR \r

  // skip spaces and EOL
  console.log("skip spaces...");
  while (c == ' ' || c == '\t' || c == '\r' || c == '\n') {
    if (c == '\n' ||                   // Linux or second char on Windows
        (c == '\r' && prev != '\n')) { // Mac, not Windows
      g_col = 1;
      g_lineStartPos = g_pos;
      g_row++;
    }
    prev = c; c = getChar();
    if (c == '\0') {
      console.log(" return tEnd");
      return Token.tEnd;
    }
  }

  // skip comments
  if (c == '/') {
    console.log("Found start of comment...");
    const c2 = getChar();
    if (c2 == '/') {  // Okay, start of one line comment was found
      do {
        c = getChar();
        console.log("skip ", c);
      } while (c != '\n' && c != '\r' && c != '\0');  // while not EOL and not EOF

      //console.log("Comment(1) finished at char: 0x%s", c.charCodeAt(0).toString(16));

      returnChar();  // we use CR LF to calculate strings so we have to return it back
      return Token.tNeedRepeat;

    } else if (c2 == '*') {  // Okay, multiline comment was found
      prev = c2; c = getChar();
      do {
        prev = c; c = getChar();
      } while ( ! (prev == '*' && c == '/') && c != '\0');  // while not "*/" and not EOF

      //console.log("Comment(2) finished at char: 0x%s", c.charCodeAt(0).toString(16));
      return Token.tNeedRepeat;

    } else {  // comment not found
      returnChar();  // Comment not found. Have to return c2 char
      return Token.tDiv;
    }
  }

  // words
  if (isLetter(c)) {
    let res: string = "";
    while (isLetter(c) || isDigit(c)) {
      res += c;
      prev = c; c = getChar();
      if (c == '\0') {
        console.log(" return tEnd");
        return Token.tEnd;
      }
    }

    console.log("Got word: \'" + res + "\' on line " + g_row);

    // Is it keyword?
    if (g_keywords.has(res)) {
      const kw = g_keywords.get(res);
      if (kw !== undefined) {
        const t: Token = kw;
        console.log("Keyword: " + t);
        return t;
      }
    }

    // Ok, this is some identifier...
    g_tokenText = res;
    let word_id: number = getWord(res);
    if (word_id < 0)
      word_id = addWord(res);

    // Now we have to return last symbol into input stream
    // otherwise symbol will be lose during 'return Token.tId;'
    returnChar();

    return Token.tId;
  }

  // numbers
  if (isDigit(c)) {
    let res: string = "";
    while (isDigit(c) || c == '.') {
      res += c;
      prev = c; c = getChar();
    }
    g_tokenText = res;
    return Token.tNumber;
  }

  // String Literal
  if (c == '\"') {
    let res: string = c;  // first "
    prev = c; c = getChar();
    while (c != '\"') {
      res += c;
    }
    res += c;  // last "
    prev = c;
    g_tokenText = res;
    return Token.tStringLiteral;
  }

  // other tokens
  if (c == '=')
    return Token.tEqual;

  if (c == '(')
    return Token.tLBracket;
  if (c == ')')
    return Token.tRBracket;

  if (c == '{')
    return Token.tLBrace;
  if (c == '}')
    return Token.tRBrace;

  if (c == '<')
    return Token.tLAngle;
  if (c == '>')
    return Token.tRAngle;

  if (c == '[')
    return Token.tLSqrBracket;
  if (c == ']')
    return Token.tRSqrBracket;

  if (c == ':')
    return Token.tColon;
  if (c == ';')
    return Token.tSemicolon;

  if (c == '.') {
    const c2 = getChar();
    const c3 = getChar();
    if (c2 == '.' && c3 == '.') {
      prev = ' ';
      return Token.tEllipsis;
    } else {
      returnChar();
      returnChar();
      prev = '.';
      return Token.tDot;
    }
  }

  if (c == ',')
    return Token.tComma;

  if (c == '+')
    return Token.tPlus;
  if (c == '-')
    return Token.tMinus;

  if (c == '*')
    return Token.tAsterisk;
  if (c == '?')
    return Token.tQuestion;

  // TODO: Probably c is some unknown char and we have to process it (and return tError).
  return Token.tNeedRepeat;
}

export function getCol() {
  return g_pos - g_lineStartPos;
}

export function getRow() {
  return g_row;
}

export function getLastLine(): string {
  let line: string = "";
  for (let i = g_lineStartPos; i < g_text.length; i++) {
    if (g_text[i] == '\r' || g_text[i] == '\n')
      break;
    line += g_text[i];
  }
  return line;
}
