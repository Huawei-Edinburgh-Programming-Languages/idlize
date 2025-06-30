
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
  tVoid = 28,
  tNumber = 29,
  tString = 30,
  tBoolean = 31,
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

  tSequence = 50,

  tShort = 60,        // short
  tLong = 61,         // long
  tUnsigned = 62,     // unsigned

  tFloat = 70,        // float
  tDouble = 71,       // double

  tByteString = 80,   // strings
  tDOMString = 81,
  tUSVString = 82,

  tId = 99,           // identifier
  tError = 100,
  tEnd = 101
};

const g_keywords = new Map<string, Token>([
  ["async", Token.tAsync],
  ["attribute", Token.tAttribute],
  ["callback", Token.tCallback],
  ["class", Token.tClass],
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
  ["package", Token.tPackage],
  ["partial", Token.tPartial],
  ["readonly", Token.tReadonly],
  ["required", Token.tRequired],
  ["setlike", Token.tSetlike],
  ["setter", Token.tSetter],
  ["static", Token.tStatic],
  ["stringifier", Token.tStringifier],
  ["typedef", Token.tTypedef],
  ["unrestricted", Token.tUnrestricted],

  ["short", Token.tShort],
  ["long", Token.tLong],
  ["unsigned", Token.tUnsigned],
]);

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
let g_token_text: string = "";

export function init(text: string) {
  g_text = text + '\n';  // Some files have no EOL in the end, so we fix it here!
  g_pos = 0;
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
    g_token_text = res;
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
    g_token_text = res;
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
