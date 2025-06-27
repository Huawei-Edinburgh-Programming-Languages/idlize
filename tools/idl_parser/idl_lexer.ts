
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
  tEq = 32,        // =
  tLBracket = 33,  // (
  tRBracket = 34,  // )
  tLBrace = 35,    // {
  tRBrace = 36,    // }
  tLAngle = 37,    // <
  tRAngle = 38,    // >
  tColon = 39,     // :
  tSemicolon = 40, // ;
  tDot = 41,       // .
  tComma = 42,     // ,
  tPlus = 43,      // +
  tMinus = 44,     // -
  tAsterisk = 45,  // *
  tEllipsis = 46,  // ...
  tQuestion = 47,  // ?
  tId = 99,
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
]);

let g_lastId = 0;
let g_words = new Map<string, number>([
//  ["word", id]
]);

function getWord(word: string): number {
  const val = g_words.get(word);
  if (g_words.has(word) && val !== undefined)
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
  g_text = text;
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

export function getToken(): Token {
  if (g_pos >= g_text.length)
    return Token.tEnd;

  let c: string = g_text[g_pos++];
  if (c == '\n') {
    g_col = 1;
    g_row++;
  }

  // spaces
  while (c == ' ' || c == '\t') {
    c = g_text[g_pos++];
  }

  // words
  if (isLetter(c)) {
    let res: string = "";
    while (isLetter(c)) {
      res += c;
      c = g_text[g_pos++];
    }
    // Is it keyword?
    const val = g_keywords.get(res);
    if (g_keywords.has(res) && val !== undefined)
      return val;

    // Ok, it is some identifier...
    g_token_text = res;
    let word_id: number = getWord(res);
    if (word_id < 0)
      word_id = addWord(res);
    return Token.tId;
  }

  // numbers
  if (isDigit(c)) {
    let res: string = "";
    while (isDigit(c) || c == '.') {
      res += c;
      c = g_text[g_pos++];
    }
    g_token_text = res;
    return Token.tNumber;
  }

  // other tokens
  if (c == '=')
    return Token.tEq;
  if (c == ';')
    return Token.tSemicolon;

  if (c == '(')
    return Token.tLBr;
  if (c == ')')
    return Token.tRBr;

  if (c == '{')
    return Token.tLCu;
  if (c == '}')
    return Token.tRCu;

  if (c == '<')
    return Token.tLAn;
  if (c == '>')
    return Token.tRAn;

  if (c == '+')
    return Token.tPlus;

  console.log("Unknown sym: \'" + c + "\'");
  return Token.tError;
}
