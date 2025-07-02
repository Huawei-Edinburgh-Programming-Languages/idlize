
const BooleanLiteral: readonly string[] = [ "true", "false" ]

const FloatLiteral: readonly string[] = [ "decimal", "-Infinity", "Infinity", "NaN" ]

export enum Token {
  tAsync = 1,
  tAttribute = 2,
  tCallback = 3,
  tClass = 4,
  tConst = 5,
  tConstructor = 6,
  tDeleter = 7,
  tDictionary = 8,
  tEnum = 9,
  tGetter = 10,
  tIncludes = 11,
  tInherit = 12,
  tInterface = 13,
  tIterable = 14,
  tMaplike = 15,
  tMixin = 16,
  tNamespace = 17,
  tPackage = 18,
  tPartial = 19,
  tReadonly = 20,
  tRequired = 21,
  tSetlike = 22,
  tSetter = 23,
  tStatic = 24,
  tStringifier = 25,
  tTypedef = 26,
  tUnrestricted = 27,

  tEqual = 32,        // =
  tLBracket = 33,     // (
  tRBracket = 34,     // )
  tLBrace = 35,       // {
  tRBrace = 36,       // }
  tLAngle = 37,       // <
  tRAngle = 38,       // >
  tLSqrBracket = 39,  // [
  tRSqrBracket = 40,  // ]
  tColon = 41,        // :
  tSemicolon = 42,    // ;
  tDot = 43,          // .
  tComma = 44,        // ,
  tPlus = 45,         // +
  tMinus = 46,        // -
  tAsterisk = 47,     // *
  tEllipsis = 48,     // ...
  tQuestion = 49,     // ?

  tShort = 60,        // short
  tLong = 61,         // long
  tUnsigned = 62,     // unsigned
  tBoolean = 63,
  tByte = 64,
  tOctet = 65,
  tBigint = 66,
  tFloat = 67,        // float
  tDouble = 68,       // double

  tString = 70,
  tByteString = 71,   // strings
  tDOMString = 72,
  tUSVString = 73,

  tVoid = 80,
  tUndefined = 81,
  tNumber = 82,
  tSequence = 83,
  tFrozenArray = 84,
  tObservableArray = 85,
  tRecord = 86,
  tObject = 87,       // I found this two types in standard but not in source code
  tSymbol = 88,

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

  tAny = 105,         // The any type is the union of all other possible non-union types.

  tId = 999,          // identifier
  tError = 1000,
  tEnd = 1001
};

const g_keywords = new Map<string, Token>([
  // ArgumentNameKeywords
  ["async", Token.tAsync],
  ["attribute", Token.tAttribute],
  ["callback", Token.tCallback],
  ["const", Token.tConst],
  ["constructor", Token.tConstructor],
  ["deleter", Token.tDeleter],
  ["dictionary", Token.tDictionary],
  ["enum", Token.tEnum],
  ["getter", Token.tGetter],
  ["includes",  Token.tIncludes],
  ["inherit", Token.tInherit],
  ["interface", Token.tInterface],
  ["iterable", Token.tIterable],
  ["maplike", Token.tMaplike],
  ["mixin",  Token.tMixin],
  ["namespace", Token.tNamespace],
  ["partial", Token.tPartial],
  ["readonly", Token.tReadonly],
  ["required", Token.tRequired],
  ["setlike", Token.tSetlike],
  ["setter", Token.tSetter],
  ["static", Token.tStatic],
  ["stringifier", Token.tStringifier],
  ["typedef", Token.tTypedef],
  ["unrestricted", Token.tUnrestricted],
  // Other tokens
  ["class", Token.tClass],  // probably do not required
  ["package", Token.tPackage],
  ["short", Token.tShort],
  ["long", Token.tLong],
  ["unsigned", Token.tUnsigned],
  ["boolean", Token.tBoolean],
  ["byte", Token.tByte],
  ["octet", Token.tOctet],
  ["bigint", Token.tBigint],

  ["float", Token.tFloat],
  ["double", Token.tDouble],

  ["String", Token.tString],
  ["ByteString", Token.tByteString],
  ["DOMString", Token.tDOMString],
  ["USVString", Token.tUSVString],

  ["void", Token.tVoid],  // void type is replaced by undefined type
                          // (c) https://github.com/w3c/webidl2.js?tab=readme-ov-file#errors
  ["undefined", Token.tUndefined],
  ["number", Token.tNumber],
  ["sequence", Token.tSequence],
  ["FrozenArray", Token.tFrozenArray],
  ["ObservableArray", Token.tObservableArray],
  ["record", Token.tRecord],
  ["object", Token.tObject],
  ["symbol", Token.tSymbol],

  ["tArrayBuffer", Token.tArrayBuffer],
  ["tSharedArrayBuffer", Token.tSharedArrayBuffer],
  ["DataView", Token.tDataView],
  ["Int8Array", Token.tInt8Array],
  ["Int16Array", Token.tInt16Array],
  ["Int32Array", Token.tInt32Array],
  ["Uint8Array", Token.tUint8Array],
  ["Uint16Array", Token.tUint16Array],
  ["Uint32Array", Token.tUint32Array],
  ["Uint8ClampedArray", Token.tUint8ClampedArray],
  ["BigInt64Array", Token.tBigInt64Array],
  ["BigUint64Array", Token.tBigUint64Array],
  ["Float16Array", Token.tFloat16Array],
  ["Float32Array", Token.tFloat32Array],
  ["Float64Array", Token.tFloat64Array],

  ["any", Token.tAny],
]);

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

// Just a part of primitive types... Also we have UnsignedIntegerType and UnrestrictedFloatType
let g_PrimitiveType: Token[] = [
  Token.tBoolean, Token.tByte, Token.tOctet, Token.tBigint,
  Token.tUnsigned, Token.tShort, Token.tLong  // TODO: check it!
];

export function IsItPrimitiveType(value: Token): boolean {
  return g_PrimitiveType.includes(value);
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

let prev: string = ' ';  // TypeScript does not support static in functions :(

function getChar(): string {
  if (g_pos >= g_text.length)
    return '\0';
  else
    return g_text[g_pos++];
}

function returnChar() {
  if (g_pos > 0)
    g_pos--;
  else
    throw new Error("Can't decrement g_pos cause it's zero.");
}

export function getToken(): Token {
  console.log("getToken <<<");
  let c: string = getChar();
  if (c == '\0') {
    console.log(" return tEnd");
    return Token.tEnd;
  }

  // Linux EOL:   0A    LF \n
  // Windows EOL: 0D 0A CR LF \r\n
  // Mac:         0D ?  CR \r

  // skip spaces and EOL
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

  //console.log("now c has value: " + c);

  // words
  if (isLetter(c)) {
    let res: string = "";
    while (isLetter(c)) {
      res += c;
      prev = c; c = getChar();
      if (c == '\0') {
        console.log(" return tEnd");
        return Token.tEnd;
      }
    }

    console.log("Got word: \'" + res + "\' on line " + g_row);
    //console.log(" c has value: " + c);

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
    prev = ' ';
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

  if (c == '.')
    return Token.tDot;
  if (c == ',')
    return Token.tComma;

  if (c == '+')
    return Token.tPlus;
  if (c == '-')
    return Token.tMinus;

  if (c == '*')
    return Token.tAsterisk;
  if (c == '...')
    return Token.tEllipsis;
  if (c == '?')
    return Token.tQuestion;

  console.log("Unknown sym: \'" + c + "\'");
  console.log("code: ", c.charCodeAt(0));
  return Token.tError;
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
