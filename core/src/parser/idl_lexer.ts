
import { Token } from "./idl_token";

const BooleanLiteral: readonly string[] = [ "true", "false" ]

const FloatLiteral: readonly string[] = [ "decimal", "-Infinity", "Infinity", "NaN" ]

export type TokenPattern = {
  pattern: RegExp;
  type: Token;
};

const g_keywords: Array<TokenPattern> = [
  { pattern: /\/\/.*/, type: Token.tComment},
  { pattern: /\/\*(.|\n)*\*\//, type: Token.tLongComment },
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
  { pattern: /dictionary/, type: Token.tDictionary},
  { pattern: /interface/, type: Token.tInterface},
  { pattern: /namespace/, type: Token.tNamespace},
  { pattern: /package/, type: Token.tPackage},
  { pattern: /partial/, type: Token.tPartial},
  { pattern: /readonly/, type: Token.tReadonly},
  { pattern: /static/, type: Token.tStatic},
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
  { pattern: /null/, type: Token.tNull},

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

  // regexp
  { pattern: /-?([1-9][0-9]*|0[Xx][0-9A-Fa-f]+|0[0-7]*)/, type: Token.tInteger},
  { pattern: /-?(([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)([Ee][+-]?[0-9]+)?|[0-9]+[Ee][+-]?[0-9]+)/, type: Token.tDecimal},
  { pattern: /[_-]?[A-Za-z][0-9A-Z_a-z-]*/, type: Token.tId},
  { pattern: /"[^"]*"/, type: Token.tString},
  { pattern: /[\t\n\r ]+/, type: Token.tWhiteSpace},
];

let g_ArgumentNameKeyword: Token[] = [
  Token.tAsync, Token.tAttribute, Token.tCallback, Token.tConst, Token.tConstructor,
  Token.tDictionary, Token.tInterface, Token.tPartial,
  Token.tNamespace, Token.tReadonly,
  Token.tStatic, Token.tTypedef, Token.tUnrestricted
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
         value == Token.tArrayBuffer ||
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

export function IsItStringType(value: Token): boolean {
  return value == Token.tString;
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

function q(s: string) {
  return "\'" + s + "\'";
}

export class TokenData {
  type: Token;
  text: string;
  col: number;
  row: number;

  constructor(type: Token, text: string = "", col: number = 0, row: number = 0) {
    this.type = type;
    this.text = text;
    this.col = col;
    this.row = row;
  }

  toString(): string {
    let res: string;
    res = typeof this + ", ";
    res += this.type + ", ";
    res += q(this.text) + " (";
    res += this.col + ", ";
    res += this.row + ")";
    return res;
  }
};

let g_text: string;
let g_pos: number = 0;
let g_col: number = 0;
let g_row: number = 0;
let g_lineStartPos = 0;

export function init(text: string) {
  g_text = text + '\n';  // Some files have no EOL in the end, so we fix it here!
  g_pos = 0;
  g_col = 0;
  g_row = 0;
  g_lineStartPos = 0;
}

export function getToken(): TokenData {
  console.log("getToken <<<");

  let nothing_found: boolean = false;
  while (g_pos < g_text.length && !nothing_found) {
    nothing_found = true;  // If none of the keywords match, then there is something wrong with the text.
    for (const kw of g_keywords) {
      const re = new RegExp(kw.pattern, "y");
      re.lastIndex = g_pos;
      const found = re.exec(g_text);
      if (found) {
        nothing_found = false;

        let tokenText: string = found[0];
        g_pos += tokenText.length;
        // comments and white spaces can contain \n
        if (kw.type == Token.tWhiteSpace ||
            kw.type == Token.tComment ||
            kw.type == Token.tLongComment) {
          let eol = 0;
          for (let c of tokenText)
            if (c === '\n') {
              g_col = 1;
              eol++;
            } else {
              g_col++;
            }
          g_row += eol;
          break;
        } else {
          g_col += tokenText.length;
        }

        console.log(tokenText);
        return new TokenData(kw.type, tokenText, g_col, g_row);
      }
    }
  }

  return new TokenData(Token.tEnd);
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
