
import * as lex from "./idl_lexer";
import * as idl from "./idl_structs";

let g_lookahead: lex.Token;

const g_char2token = new Map<string, lex.Token>([
  ["=", lex.Token.tEqual],
  ["(", lex.Token.tLBracket],
  [")", lex.Token.tRBracket],
  ["{", lex.Token.tLBrace],
  ["}", lex.Token.tRBrace],
  ["<", lex.Token.tLAngle],
  [">", lex.Token.tRAngle],
  ["[", lex.Token.tLSqrBracket],
  ["]", lex.Token.tRSqrBracket],
  [":", lex.Token.tColon],
  [";", lex.Token.tSemicolon],
  [".", lex.Token.tDot],
  [",", lex.Token.tComma],
  ["+", lex.Token.tPlus],
  ["-", lex.Token.tMinus],
  ["*", lex.Token.tAsterisk],
  ["...", lex.Token.tEllipsis],
  ["?", lex.Token.tQuestion],
  ["any", lex.Token.tAny],
  ["Id", lex.Token.tId],
  ["or", lex.Token.tOr],
]);

function token2Name(t: lex.Token): string {
  let res: string = "??";
  g_char2token.forEach((value, key) => {
    if (value === t) {
      res = key;
    }
  });

  return res;
}

function Match(tArg: lex.Token | string) {
  let tok: lex.Token;
  let tok_name: string = "";
  if (typeof tArg === 'string') {
    if (g_char2token.has(tArg)) {
      tok_name = " (" + tArg + ")";
      tok = g_char2token.get(tArg) ! ;
    } else {
      console.log("Error. Unknown symbol: " + tArg);
      tok = lex.Token.tError;
    }
  } else {
    tok = tArg;
  }

  if (g_lookahead == tok) {
     console.log("Match ok: " + tok + tok_name);
     g_lookahead = lex.getToken();
     console.log("new:  " + g_lookahead);
  } else {
    let msg: string = "Match Error. Waiting for: " +
                      tok + "(\'" + token2Name(tok) + "\')" + ", but got " +
                      g_lookahead + "(\'" + token2Name(g_lookahead) + "\')";

    msg += " at pos: (" + lex.getCol() + ", " + lex.getRow() + ")\n";
    msg += lex.getLastLine() + "\n";
    msg += '-'.repeat(lex.getCol() - 1) + "^";  // -1 means that human start line from col == 1
                                                // and there is no spaces (' ') to the left of the first column
    throw new Error(msg);
  }
}

export function Parse(): idl.Definitions | null {
  const idl: string =
`package arkui.component.idlize;
callback Callback_Extender_OnProgress = void (f32 value);`
//import arkui.component.common;
  console.log("Try to parse:");
  console.log(idl);

  lex.init(idl);

  // Debug code
  /*for (let i: number = 0; i < 10; i++) {
    g_lookahead = lex.getToken();
    console.log("LookAhead[" + i + "]: " + g_lookahead + " == \'" + token2Name(g_lookahead) + "\'");
  }
  throw new Error("Done!");*/
  // Debug code

  let defs: idl.Definitions | null = null;

  g_lookahead = lex.getToken();
  if (g_lookahead != lex.Token.tError && g_lookahead != lex.Token.tEnd) {
    defs = Definitions(); // starting production
  }

  console.log("The end!");
  return defs;
}

// starting production
function Definitions(): idl.Definitions {
  let res: idl.Definitions = new idl.Definitions();
  do {
    if (g_lookahead == lex.Token.tLSqrBracket)
      ExtendedAttributeList();

    let node: idl.Node | null = Definition();
    if (node)
      res.nodes.push(node);
    else
      console.log("Node is null");
  } while (g_lookahead != lex.Token.tEnd);
  //Definitions();
  // ε
  return res;
}

function Definition(): idl.Node | null {
  if (g_lookahead == lex.Token.tCallback ||
      g_lookahead == lex.Token.tMixin)
    return CallbackOrInterfaceOrMixin();
  else if (g_lookahead == lex.Token.tNamespace)
    return Namespace();
  else if (g_lookahead == lex.Token.tPartial)
    return Partial();
  else if (g_lookahead == lex.Token.tDictionary)
    return Dictionary();
  else if (g_lookahead == lex.Token.tEnum)
    return Enum();
  else if (g_lookahead == lex.Token.tTypedef)
    return Typedef();
  else if (g_lookahead == lex.Token.tIncludes)
    return IncludesStatement();
  else if (g_lookahead == lex.Token.tPackage)
    return Package();
  else {
    let txt = "Got unexpected token: " + g_lookahead;
    console.log(txt);
    throw new Error(txt);
  }
}

function CallbackOrInterfaceOrMixin(): idl.Node | null {
  if (g_lookahead == lex.Token.tCallback) {
    Match(lex.Token.tCallback);
    return CallbackRestOrInterface();
  } else if (g_lookahead == lex.Token.tMixin) {
    Match(lex.Token.tInterface); InterfaceOrMixin();
  }

  return null;
}

function InterfaceOrMixin() {
  InterfaceRest();
  MixinRest();
}

function InterfaceRest() {
  Match(lex.Token.tId); Inheritance(); Match(lex.Token.tLBrace); InterfaceMembers(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);
}

function Partial(): idl.Node | null {
  Match(lex.Token.tPartial); PartialDefinition();

  return null;
}

function PartialDefinition() {
  Match(lex.Token.tInterface); PartialInterfaceOrPartialMixin();
  PartialDictionary();
  Namespace();
}

function PartialInterfaceOrPartialMixin() {
  PartialInterfaceRest();
  MixinRest();
}

function PartialInterfaceRest() {
  Match(lex.Token.tId); Match(lex.Token.tLBrace); PartialInterfaceMembers(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);
}

function InterfaceMembers() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  InterfaceMember(); InterfaceMembers();
  // ε
}

function InterfaceMember() {
  PartialInterfaceMember();
  Constructor();
}

function PartialInterfaceMembers() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  PartialInterfaceMember(); PartialInterfaceMembers();
  // ε
}

function PartialInterfaceMember() {
  Const();
  Operation();
  Stringifier();
  StaticMember();
  Iterable();
  AsyncIterable();
  ReadOnlyMember();
  ReadWriteAttribute();
  ReadWriteMaplike();
  ReadWriteSetlike();
  InheritAttribute();
}

function Inheritance() {
  Match(lex.Token.tColon); Match(lex.Token.tId);
  // ε
}

function MixinRest() {
  Match(lex.Token.tMixin); Match(lex.Token.tId); Match(lex.Token.tLBrace); MixinMembers(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);
}

function MixinMembers() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  MixinMember(); MixinMembers();
  // ε
}

function MixinMember() {
  Const();
  RegularOperation();
  Stringifier();
  OptionalReadOnly(); AttributeRest();
}

function IncludesStatement(): idl.Node | null {
  Match(lex.Token.tId); Match(lex.Token.tIncludes); Match(lex.Token.tId); Match(lex.Token.tSemicolon);

  return null;
}

function Package(): idl.Node | null {
  Match(lex.Token.tPackage);
  while (g_lookahead != lex.Token.tEnd) {
    Match(lex.Token.tId);
    if (g_lookahead == lex.Token.tSemicolon)
      break;
    Match(lex.Token.tDot);
  }
  Match(lex.Token.tSemicolon);

  return null;
}

function CallbackRestOrInterface(): idl.Node | null {
  if (g_lookahead == lex.Token.tInterface) {
    Match(lex.Token.tInterface);
    Match(lex.Token.tId);
    Match(lex.Token.tLBrace);
    CallbackInterfaceMembers();
    Match(lex.Token.tRBrace);
    Match(lex.Token.tSemicolon);
    return null;
  } else {
    return CallbackRest();
  }
}

function CallbackInterfaceMembers() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  CallbackInterfaceMember(); CallbackInterfaceMembers();
  // ε
}

function CallbackInterfaceMember() {
  Const();
  RegularOperation();
}

function Const() {
  Match(lex.Token.tConst); ConstType(); Match(lex.Token.tId); Match(lex.Token.tEqual); ConstValue(); Match(lex.Token.tSemicolon);
}

function ConstValue() {
  BooleanLiteral();
  FloatLiteral();
  Match(lex.Token.tIntegerLiteral);  // terminal matched by the regular expressions
}

function BooleanLiteral() {
  //true
  //false
}

function FloatLiteral() {
  /*decimal
  -Infinity
  Infinity
  NaN*/
}

function ConstType() {
  PrimitiveType();
  Match(lex.Token.tId);
}

function ReadOnlyMember() {
  Match(lex.Token.tReadonly); ReadOnlyMemberRest();
}

function ReadOnlyMemberRest() {
  AttributeRest();
  MaplikeRest();
  SetlikeRest();
}

function ReadWriteAttribute() {
  AttributeRest();
}

function InheritAttribute() {
  Match(lex.Token.tInherit); AttributeRest();
}

function AttributeRest() {
  Match(lex.Token.tAttribute); TypeWithExtendedAttributes(); AttributeName(); Match(lex.Token.tSemicolon);
}

function AttributeName() {
  AttributeNameKeyword();
  Match(lex.Token.tId);
}

function AttributeNameKeyword() {
  //async
  //required
}

function OptionalReadOnly() {
  Match(lex.Token.tReadonly);
  // ε
}

function DefaultValue() {
  ConstValue();
  /*string
  [ ]
  { }
  null
  undefined*/
}

function Operation() {
  RegularOperation();
  SpecialOperation();
}

function RegularOperation() {
  Type(); OperationRest();
}

function SpecialOperation() {
  Special(); RegularOperation();
}

function Special() {
  /*getter
  setter
  deleter*/
}

function OperationRest() {
  OptionalOperationName(); Match(lex.Token.tLBracket); ArgumentList(); Match(lex.Token.tRBracket); Match(lex.Token.tSemicolon);
}

function OptionalOperationName() {
  if (g_lookahead == lex.Token.tId) {
    OperationName();
  } else {
    // ε
  }
}

function OperationName() {
  OperationNameKeyword();
  Match(lex.Token.tId);
}

function OperationNameKeyword() {
  Match(lex.Token.tIncludes);
}

function ArgumentList() {
  Argument(); Arguments();
  // ε
}

function Arguments() {
  while (g_lookahead == lex.Token.tComma) {
    Match(lex.Token.tComma); Argument();
  }
  // ε
}

function Argument() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  ArgumentRest();
}

function ArgumentRest() {
  if (g_lookahead == lex.Token.tOptional) {
    Match(lex.Token.tOptional); TypeWithExtendedAttributes(); ArgumentName(); Default();
  } else {
    Match(lex.Token.tId); Ellipsis(); ArgumentName();  // I replace Type to Id
  }
}

function ArgumentName() {
  if (lex.IsItArgumentNameKeyword(g_lookahead))
    Match(g_lookahead);  // hm-hm...
  Match(lex.Token.tId);
}

function Ellipsis() {
  //...
  if (g_lookahead == lex.Token.tEllipsis)
    Match(lex.Token.tEllipsis);
  else {
  }
  // ε
}

function Constructor() {
  Match(lex.Token.tConstructor); Match(lex.Token.tLBracket); ArgumentList(); Match(lex.Token.tRBracket); Match(lex.Token.tSemicolon);
}

function Stringifier() {
  Match(lex.Token.tStringifier); StringifierRest();
}

function StringifierRest() {
  OptionalReadOnly(); AttributeRest();
  Match(lex.Token.tSemicolon);
}

function StaticMember() {
  Match(lex.Token.tStatic); StaticMemberRest();
}

function StaticMemberRest() {
  OptionalReadOnly(); AttributeRest();
  RegularOperation();
}

function Iterable() {
  Match(lex.Token.tIterable); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); OptionalType(); Match(lex.Token.tRAngle); Match(lex.Token.tSemicolon);
}

function OptionalType() {
  Match(lex.Token.tComma); TypeWithExtendedAttributes();
  // ε
}

function AsyncIterable() {
  Match(lex.Token.tAsync); Match(lex.Token.tIterable); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); OptionalType(); Match(lex.Token.tRAngle); OptionalArgumentList(); Match(lex.Token.tSemicolon);
}

function OptionalArgumentList() {
  Match(lex.Token.tLBracket); ArgumentList(); Match(lex.Token.tRBracket);
  // ε
}

function ReadWriteMaplike() {
  MaplikeRest();
}

function MaplikeRest() {
  Match(lex.Token.tMaplike); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); Match(lex.Token.tComma); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle); Match(lex.Token.tSemicolon);
}

function ReadWriteSetlike() {
  SetlikeRest();
}

function SetlikeRest() {
  Match(lex.Token.tSetlike); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle); Match(lex.Token.tSemicolon);
}

function Namespace() {
  Match(lex.Token.tNamespace); Match(lex.Token.tId); Match(lex.Token.tLBrace); NamespaceMembers(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);
  return null;
}

function NamespaceMembers() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  NamespaceMember(); NamespaceMembers();
  // ε
}

function NamespaceMember() {
  RegularOperation();
  Match(lex.Token.tReadonly); AttributeRest();
  Const();
}

function Dictionary(): idl.Node | null {
  Match(lex.Token.tDictionary); Match(lex.Token.tId); Inheritance(); Match(lex.Token.tLBrace); DictionaryMembers(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);

  return null;
}

function DictionaryMembers() {
  DictionaryMember(); DictionaryMembers();
  // ε
}

function DictionaryMember() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  DictionaryMemberRest();
}

function DictionaryMemberRest() {
  Match(lex.Token.tRequired); TypeWithExtendedAttributes(); Match(lex.Token.tId); Match(lex.Token.tSemicolon);
  Type(); Match(lex.Token.tId); Default(); Match(lex.Token.tSemicolon);
}

function PartialDictionary() {
  Match(lex.Token.tDictionary); Match(lex.Token.tId); Match(lex.Token.tLBrace); DictionaryMembers(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);
}

function Default() {
  if (g_lookahead == lex.Token.tEqual) {
    Match(lex.Token.tEqual); DefaultValue();
  } else {
    // ε
  }
}

function Enum(): idl.Node | null {
  Match(lex.Token.tEnum); Match(lex.Token.tId); Match(lex.Token.tLBrace); EnumValueList(); Match(lex.Token.tRBrace); Match(lex.Token.tSemicolon);

  return null;
}

function EnumValueList() {
  Match("string"); EnumValueListComma();
}

function EnumValueListComma() {
  Match(lex.Token.tComma); EnumValueListString();
  // ε
}

function EnumValueListString() {
  Match("string"); EnumValueListComma();
  // ε
}

function CallbackRest(): idl.Node | null {
  if (g_lookahead != lex.Token.tId)
    return null;

  let res: idl.CallbackNode = new idl.CallbackNode(lex.getTokenText());
  Match(lex.Token.tId);
  Match(lex.Token.tEqual);
  Type();
  Match(lex.Token.tLBracket);
  ArgumentList();
  Match(lex.Token.tRBracket);
  Match(lex.Token.tSemicolon);
  return res;
}

function Typedef(): idl.Node | null {
  Match(lex.Token.tTypedef); TypeWithExtendedAttributes(); Match(lex.Token.tId); Match(lex.Token.tSemicolon);

  return null;
}

function Type() {
  if (! SingleType()) {
    UnionType(); Null();
  }
}

function TypeWithExtendedAttributes() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  Type();
}

function SingleType(): boolean {
  if (g_lookahead == lex.Token.tPromise) {
    PromiseType();
    return true;
  } else if  (g_lookahead == lex.Token.tAny) {
    Match(lex.Token.tAny);
    return true;
  } else {
    return DistinguishableType();
  }
}

function UnionType() {
  if (g_lookahead == lex.Token.tLBracket) {
    Match(lex.Token.tLBracket); UnionMemberType(); Match(lex.Token.tOr); UnionMemberType(); UnionMemberTypes(); Match(lex.Token.tRBracket);
  }
}

function UnionMemberType() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  DistinguishableType();
  UnionType(); Null();
}

function UnionMemberTypes() {
  Match(lex.Token.tOr); UnionMemberType(); UnionMemberTypes();
  // ε
}

function DistinguishableType(): boolean {
  let processed: boolean = true;
  if (lex.IsItPrimitiveType(g_lookahead)) {
    PrimitiveType(); Null();
  } else if (lex.IsItStringType(g_lookahead)) {
    StringType(); Null();
  } else if (g_lookahead == lex.Token.tId) {  // ! кажется, именно это условие должно пропускать произвольный пользовательский тип!
    Match(lex.Token.tId); Null();
  } else if (g_lookahead == lex.Token.tSequence) {
    Match(lex.Token.tSequence); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle); Null();
  } else if (g_lookahead == lex.Token.tAsync) {
    Match(lex.Token.tAsync); Match(lex.Token.tIterable); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle); Null();
  } else if (g_lookahead == lex.Token.tObject) {
    Match(lex.Token.tObject); Null();
  } else if (g_lookahead == lex.Token.tSymbol) {
    Match(lex.Token.tSymbol); Null();
  } else if (lex.IsItBufferRelatedType(g_lookahead)) {
    BufferRelatedType(); Null();
  } else if (g_lookahead == lex.Token.tFrozenArray) {
    Match(lex.Token.tFrozenArray); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle); Null();
  } else if (g_lookahead == lex.Token.tObservableArray) {
    Match(lex.Token.tObservableArray); Match(lex.Token.tLAngle); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle); Null();
  } else if (g_lookahead == lex.Token.tRecord) {
    RecordType(); Null();
  } else if (g_lookahead == lex.Token.tVoid) {
    Match(lex.Token.tVoid); Null();
  } else if (g_lookahead == lex.Token.tUndefined) {
    Match(lex.Token.tUndefined); Null();
  } else {  // FIXME!!! костыль... нужен для того, чтобы снаружи можно было понять, удалось ли обработать текущий токен
    processed = false;
  }
  return processed;
}

function PrimitiveType() {
  UnsignedIntegerType();
  UnrestrictedFloatType();
  if (g_lookahead == lex.Token.tBoolean) {
    Match(lex.Token.tBoolean);
  } else if (g_lookahead == lex.Token.tByte) {
    Match(lex.Token.tByte);
  } else if (g_lookahead == lex.Token.tOctet) {
    Match(lex.Token.tOctet);
  } else if (g_lookahead == lex.Token.tBigint) {
    Match(lex.Token.tBigint);
  }
}

function UnrestrictedFloatType() {
  if (g_lookahead == lex.Token.tUnrestricted) {
    Match(lex.Token.tUnrestricted); FloatType();
  } else {
    FloatType();
  }
}

function FloatType() {
  if (g_lookahead == lex.Token.tFloat) {
    Match(lex.Token.tFloat);
  } else if (g_lookahead == lex.Token.tDouble) {
    Match(lex.Token.tDouble);
  }
}

function UnsignedIntegerType() {
  if (g_lookahead == lex.Token.tUnsigned) {
    Match(lex.Token.tUnsigned); IntegerType();
  }
  IntegerType();
}

function IntegerType() {
  if (g_lookahead == lex.Token.tShort) {
    Match(lex.Token.tShort);
  } else if (g_lookahead == lex.Token.tLong) {
    Match(lex.Token.tLong);
    OptionalLong();
  }
}

function OptionalLong() {
  if (g_lookahead == lex.Token.tLong) {
    Match(lex.Token.tLong);
  }
  // | ε
}

function StringType() {
  if (g_lookahead == lex.Token.tByteString) {
    Match(lex.Token.tByteString);
  } else if (g_lookahead == lex.Token.tDOMString) {
    Match(lex.Token.tDOMString);
  } else if (g_lookahead == lex.Token.tUSVString) {
    Match(lex.Token.tUSVString);
  }
}

function PromiseType() {
  if (g_lookahead == lex.Token.tPromise) {
    Match(lex.Token.tPromise); Match(lex.Token.tLAngle); Type(); Match(lex.Token.tRAngle);
  }
}

function RecordType() {
  Match(lex.Token.tRecord); Match(lex.Token.tLAngle); StringType(); Match(lex.Token.tComma); TypeWithExtendedAttributes(); Match(lex.Token.tRAngle);
}

function Null() {
  if (g_lookahead == lex.Token.tQuestion) {
    Match(lex.Token.tQuestion);
  } else {
    // ε
  }
}

function BufferRelatedType() {
/*
  ArrayBuffer();
  SharedArrayBuffer();
  DataView();
  Int8Array();
  Int16Array();
  Int32Array();
  Uint8Array();
  Uint16Array();
  Uint32Array();
  Uint8ClampedArray();
  BigInt64Array();
  BigUint64Array();
  Float16Array();
  Float32Array();
  Float64Array();
*/
}

function ExtendedAttributeList() {
  if (g_lookahead == lex.Token.tLSqrBracket) {
    Match(lex.Token.tLSqrBracket); ExtendedAttribute(); ExtendedAttributes(); Match(lex.Token.tRSqrBracket);
  } else {
    // ε
  }
}

function ExtendedAttributes() {
  if (g_lookahead == lex.Token.tComma) {
    Match(lex.Token.tComma); ExtendedAttribute(); ExtendedAttributes();
  } else {
    // ε
  }
}

function ExtendedAttribute() {
  Match(lex.Token.tLBracket); ExtendedAttributeInner(); Match(lex.Token.tRBracket); ExtendedAttributeRest();
  Match(lex.Token.tLSqrBracket); ExtendedAttributeInner(); Match(lex.Token.tRSqrBracket); ExtendedAttributeRest();
  Match(lex.Token.tLBrace); ExtendedAttributeInner(); Match(lex.Token.tRBrace); ExtendedAttributeRest();
  Other(); ExtendedAttributeRest();
}

function ExtendedAttributeRest() {
  ExtendedAttribute();
  // ε
}

function ExtendedAttributeInner() {
  Match(lex.Token.tLBracket); ExtendedAttributeInner(); Match(lex.Token.tRBracket); ExtendedAttributeInner();
  Match(lex.Token.tLSqrBracket); ExtendedAttributeInner(); Match(lex.Token.tRSqrBracket); ExtendedAttributeInner();
  Match(lex.Token.tLBrace); ExtendedAttributeInner(); Match(lex.Token.tRBrace); ExtendedAttributeInner();
  OtherOrComma(); ExtendedAttributeInner();
  // ε
}

function Other() {
  "integer"
  "decimal"
  lex.Token.tId
  "string"
  "other"
  "-"
  "-Infinity"
  "."
  "..."
  ":"
  ";"
  "<"
  "="
  ">"
  "?"
  "*"
  "ByteString"
  "DOMString"
  "FrozenArray"
  "Infinity"
  "NaN"
  "ObservableArray"
  "Promise"
  "USVString"
  "any"
  "bigint"
  "boolean"
  "byte"
  "double"
  "false"
  "float"
  "long"
  "null"
  "object"
  "octet"
  "or"
  "optional"
  "record"
  "sequence"
  "short"
  "symbol"
  "true"
  "unsigned"
  "undefined"
  "ArgumentNameKeyword"
  "BufferRelatedType"
}

function OtherOrComma() {
  Other();
  Match(lex.Token.tComma);
}

function IdentifierList() {
  Match(lex.Token.tId); Identifiers();
}

function Identifiers() {
  if (g_lookahead == lex.Token.tComma) {
    Match(lex.Token.tComma); Match(lex.Token.tId); Identifiers();
  } else {
    // ε
  }
}

function ExtendedAttributeNoArgs() {
  Match(lex.Token.tId);
}

function ExtendedAttributeArgList() {
  Match(lex.Token.tId); Match(lex.Token.tLBracket); ArgumentList(); Match(lex.Token.tRBracket);
}

function ExtendedAttributeIdent() {
  Match(lex.Token.tId); Match(lex.Token.tEqual); Match(lex.Token.tId);
}

function ExtendedAttributeWildcard() {
  Match(lex.Token.tId); Match(lex.Token.tEqual); Match(lex.Token.tAsterisk);
}

function ExtendedAttributeIdentList() {
  Match(lex.Token.tId); Match(lex.Token.tEqual); Match(lex.Token.tLBracket); IdentifierList(); Match(lex.Token.tRBracket);
}

function ExtendedAttributeNamedArgList() {
  Match(lex.Token.tId); Match(lex.Token.tEqual); Match(lex.Token.tId); Match(lex.Token.tLBracket); ArgumentList(); Match(lex.Token.tRBracket);
}
