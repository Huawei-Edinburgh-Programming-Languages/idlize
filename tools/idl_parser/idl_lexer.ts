
const ArgumentNameKeyword: readonly string[] = [
  "async", "attribute", "callback", "const", "constructor", 
  "deleter", "dictionary", "enum", "getter", "includes", 
  "inherit", "interface", "iterable", "maplike", "mixin", 
  "namespace", "partial", "readonly", "required", "setlike", 
  "setter", "static", "stringifier", "typedef", "unrestricted" ]

const BooleanLiteral: readonly string[] = [ "true", "false" ]

const FloatLiteral: readonly string[] = [ "decimal", "-Infinity", "Infinity", "NaN" ]

export enum Token {
  tId = 1,
  tPackage = 2,
  tInterface = 3,
  tClass = 4,
  tConst = 5,
  tVoid = 6,
  tNumber = 7,
  tString = 8,
  tBoolean = 9,
  tEq = 10,
  tLBr = 11,
  tRBr = 12,
  tLCu = 13,
  tRCu = 14,
  tLAn = 14,
  tRAn = 15,
  tSemicolon = 16,
  tPlus = 17,
  tError = 100,
  tEnd = 101
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

  while (c == ' ') {
    c = g_text[g_pos++];
  }

  // words
  if (isLetter(c)) {
    let res: string = "";
    while (isLetter(c)) {
      res += c;
      c = g_text[g_pos++];
    }
    g_token_text = res;
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
