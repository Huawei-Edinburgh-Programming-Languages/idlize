
import * as lex from "./idl_lexer";

let g_lookahead: lex.Token;

const g_char2token = new Map<string, lex.Token>([
  ["=", lex.Token.tEq],
  ["(", lex.Token.tLBracket],
  [")", lex.Token.tRBracket],
  ["{", lex.Token.tLBrace],
  ["}", lex.Token.tRBrace],
  ["[", lex.Token.tLSqrBracket],
  ["]", lex.Token.tRSqrBracket],
  ["<", lex.Token.tLAngle],
  [">", lex.Token.tRAngle],
  [":", lex.Token.tColon],
  [";", lex.Token.tSemicolon],
  [".", lex.Token.tDot],
  [",", lex.Token.tComma],
  ["+", lex.Token.tPlus],
  ["-", lex.Token.tMinus],
  ["*", lex.Token.tAsterisk],
  ["...", lex.Token.tEllipsis],
  ["?", lex.Token.tQuestion],
]);

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
    throw new Error("Match Error. Waiting for: " + tok + ", but got " + g_lookahead);
  }
}

export function Parse() {
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
    console.log("LookAhead[" + i + "]: " + g_lookahead);
  }
  throw new Error("Done!");*/
  // Debug code

  let i = 0;

  g_lookahead = lex.getToken();
  while (g_lookahead != lex.Token.tError && g_lookahead != lex.Token.tEnd) {
    console.log("LookAhead: " + g_lookahead);
    Definitions(); // starting production
    g_lookahead = lex.getToken();
    i++;
    if (i > 10)
      break;
  }

  console.log("The end!");
}

// starting production
function Definitions() {
  do {
    if (g_lookahead == lex.Token.tLSqrBracket)
      ExtendedAttributeList();
    Definition();
  } while (g_lookahead != lex.Token.tEnd);
  //Definitions();
  // ε
}

function Definition() {
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

function ArgumentNameKeyword() {
/*    async
    attribute
    callback
    const
    constructor
    deleter
    dictionary
    enum
    getter
    includes
    inherit
    interface
    iterable
    maplike
    mixin
    namespace
    partial
    readonly
    required
    setlike
    setter
    static
    stringifier
    typedef
    unrestricted*/
}

function CallbackOrInterfaceOrMixin() {
  if (g_lookahead == lex.Token.tCallback) {
    Match(lex.Token.tCallback); CallbackRestOrInterface();
  }
  if (g_lookahead == lex.Token.tMixin) {
    Match(lex.Token.tInterface); InterfaceOrMixin();
  }
}

function InterfaceOrMixin() {
  InterfaceRest();
  MixinRest();
}

function InterfaceRest() {
  Match(lex.Token.tId); Inheritance(); Match("{"); InterfaceMembers(); Match("}"); Match(";");
}

function Partial() {
  Match("partial"); PartialDefinition();
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
  Match(lex.Token.tId); Match("{"); PartialInterfaceMembers(); Match("}"); Match(";");
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
  Match(":"); Match(lex.Token.tId);
  // ε
}

function MixinRest() {
  Match("mixin"); Match(lex.Token.tId); Match("{"); MixinMembers(); Match("}"); Match(";");
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

function IncludesStatement() {
  Match(lex.Token.tId); Match("includes"); Match(lex.Token.tId); Match(";");
}

function Package() {
  Match(lex.Token.tPackage);
  while (1) {
    Match(lex.Token.tId);
    if (g_lookahead == lex.Token.tSemicolon)
      break;
    Match(lex.Token.tDot);
  }
  Match(";");
}

function CallbackRestOrInterface() {
  CallbackRest();
  Match(lex.Token.tInterface); Match(lex.Token.tId); Match("{"); CallbackInterfaceMembers(); Match("}"); Match(";");
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
  Match("const"); ConstType(); Match(lex.Token.tId); Match("="); ConstValue(); Match(";");
}

function ConstValue() {
  BooleanLiteral();
  FloatLiteral();
  Match("integer");
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
  Match("readonly"); ReadOnlyMemberRest();
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
  Match("inherit"); AttributeRest();
}

function AttributeRest() {
  Match("attribute"); TypeWithExtendedAttributes(); AttributeName(); Match(";");
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
  Match("readonly");
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
  Match("Type"); OperationRest();
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
  OptionalOperationName(); Match("("); ArgumentList(); Match(")"); Match(";");
}

function OptionalOperationName() {
  OperationName();
  // ε
}

function OperationName() {
  OperationNameKeyword();
  Match(lex.Token.tId);
}

function OperationNameKeyword() {
  Match("includes");
}

function ArgumentList() {
  Argument(); Arguments();
  // ε
}

function Arguments() {
  Match(","); Argument(); Arguments();
  // ε
}

function Argument() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  ArgumentRest();
}

function ArgumentRest() {
  Match("optional"); TypeWithExtendedAttributes(); ArgumentName(); Default();
  Match("Type"); Ellipsis(); ArgumentName();
}

function ArgumentName() {
  ArgumentNameKeyword();
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
  Match("constructor"); Match("("); ArgumentList(); Match(")"); Match(";");
}

function Stringifier() {
  Match("stringifier"); StringifierRest();
}

function StringifierRest() {
  OptionalReadOnly(); AttributeRest();
  Match(";");
}

function StaticMember() {
  Match("static"); StaticMemberRest();
}

function StaticMemberRest() {
  OptionalReadOnly(); AttributeRest();
  RegularOperation();
}

function Iterable() {
  Match("iterable"); Match("<"); TypeWithExtendedAttributes(); OptionalType(); Match(">"); Match(";");
}

function OptionalType() {
  Match(","); TypeWithExtendedAttributes();
  // ε
}

function AsyncIterable() {
  Match("async"); Match("iterable"); Match("<"); TypeWithExtendedAttributes(); OptionalType(); Match(">"); OptionalArgumentList(); Match(";");
}

function OptionalArgumentList() {
  Match("("); ArgumentList(); Match(")");
  // ε
}

function ReadWriteMaplike() {
  MaplikeRest();
}

function MaplikeRest() {
  Match("maplike"); Match("<"); TypeWithExtendedAttributes(); Match(","); TypeWithExtendedAttributes(); Match(">"); Match(";");
}

function ReadWriteSetlike() {
  SetlikeRest();
}

function SetlikeRest() {
  Match("setlike"); Match("<"); TypeWithExtendedAttributes(); Match(">"); Match(";");
}

function Namespace() {
  Match("namespace"); Match(lex.Token.tId); Match("{"); NamespaceMembers(); Match("}"); Match(";");
}

function NamespaceMembers() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  NamespaceMember(); NamespaceMembers();
  // ε
}

function NamespaceMember() {
  RegularOperation();
  Match("readonly"); AttributeRest();
  Const();
}

function Dictionary() {
  Match("dictionary"); Match(lex.Token.tId); Inheritance(); Match("{"); DictionaryMembers(); Match("}"); Match(";");
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
  Match("required"); TypeWithExtendedAttributes(); Match(lex.Token.tId); Match(";");
  Type(); Match(lex.Token.tId); Default(); Match(";");
}

function PartialDictionary() {
  Match("dictionary"); Match(lex.Token.tId); { DictionaryMembers(); } Match(";");
}

function Default() {
  Match("="); DefaultValue();
  // ε
}

function Enum() {
  Match("enum"); Match(lex.Token.tId); Match("{"); EnumValueList(); Match("}"); Match(";");
}

function EnumValueList() {
  Match("string"); EnumValueListComma();
}

function EnumValueListComma() {
  Match(","); EnumValueListString();
  // ε
}

function EnumValueListString() {
  Match("string"); EnumValueListComma();
  // ε
}

function CallbackRest() {
  Match(lex.Token.tId); Match("="); Type(); Match("("); ArgumentList(); Match(")"); Match(";");
}

function Typedef() {
  Match("typedef"); TypeWithExtendedAttributes(); Match(lex.Token.tId); Match(";");
}

function Type() {
  SingleType();
  UnionType(); Null();
}

function TypeWithExtendedAttributes() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  Type();
}

function SingleType() {
  DistinguishableType();
  Match("any");
  PromiseType();
}

function UnionType() {
  Match("("); UnionMemberType(); Match("or"); UnionMemberType(); UnionMemberTypes(); Match(")");
}

function UnionMemberType() {
  if (g_lookahead == lex.Token.tLSqrBracket)
    ExtendedAttributeList();
  DistinguishableType();
  UnionType(); Null();
}

function UnionMemberTypes() {
  Match("or"); UnionMemberType(); UnionMemberTypes();
  // ε
}

function DistinguishableType() {
  PrimitiveType(); Null();
  StringType(); Null();
  Match(lex.Token.tId); Null();
  Match("sequence"); Match("<"); TypeWithExtendedAttributes(); Match(">"); Null();
  Match("async"); Match("iterable"); Match("<"); TypeWithExtendedAttributes(); Match(">"); Null();
  Match("object"); Null();
  Match("symbol"); Null();
  BufferRelatedType(); Null();
  Match("FrozenArray"); Match("<"); TypeWithExtendedAttributes(); Match(">"); Null();
  Match("ObservableArray"); Match("<"); TypeWithExtendedAttributes(); Match(">"); Null();
  RecordType(); Null();
  Match("undefined"); Null();
}

function PrimitiveType() {
  UnsignedIntegerType();
  UnrestrictedFloatType();
  "boolean"
  "byte"
  "octet"
  "bigint"
}

function UnrestrictedFloatType() {
  Match("unrestricted"); FloatType();
  FloatType();
}

function FloatType() {
  "float"
  "double"
}

function UnsignedIntegerType() {
  Match("unsigned"); IntegerType();
  IntegerType();
}

function IntegerType() {
  Match("short");
  Match("long"); OptionalLong();
}

function OptionalLong() {
  Match("long");
  // ε
}

function StringType() {
  Match("ByteString");
  Match("DOMString");
  Match("USVString");
}

function PromiseType() {
  Match("Promise"); Match("<"); Type(); Match(">");
}

function RecordType() {
  Match("record"); Match("<"); StringType(); Match(","); TypeWithExtendedAttributes(); Match(">");
}

function Null() {
  Match("?");
  // ε
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
  Match("["); ExtendedAttribute(); ExtendedAttributes(); Match("]");
  // ε
}

function ExtendedAttributes() {
  Match(","); ExtendedAttribute(); ExtendedAttributes();
  // ε
}

function ExtendedAttribute() {
  Match("("); ExtendedAttributeInner(); Match(")"); ExtendedAttributeRest();
  Match("["); ExtendedAttributeInner(); Match("]"); ExtendedAttributeRest();
  Match("{"); ExtendedAttributeInner(); Match("}"); ExtendedAttributeRest();
  Other(); ExtendedAttributeRest();
}

function ExtendedAttributeRest() {
  ExtendedAttribute();
  // ε
}

function ExtendedAttributeInner() {
  Match("("); ExtendedAttributeInner(); Match(")"); ExtendedAttributeInner();
  Match("["); ExtendedAttributeInner(); Match("]"); ExtendedAttributeInner();
  Match("{"); ExtendedAttributeInner(); Match("}"); ExtendedAttributeInner();
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
  Match(",");
}

function IdentifierList() {
  Match(lex.Token.tId); Identifiers();
}

function Identifiers() {
  if (g_lookahead == lex.Token.tComma) {
    Match(","); Match(lex.Token.tId); Identifiers();
  } else {
    // ε
  }
}

function ExtendedAttributeNoArgs() {
  Match(lex.Token.tId);
}

function ExtendedAttributeArgList() {
  Match(lex.Token.tId); Match("("); ArgumentList(); Match(")");
}

function ExtendedAttributeIdent() {
  Match(lex.Token.tId); Match("="); Match(lex.Token.tId);
}

function ExtendedAttributeWildcard() {
  Match(lex.Token.tId); Match("="); Match("*");
}

function ExtendedAttributeIdentList() {
  Match(lex.Token.tId); Match("="); Match("("); IdentifierList(); Match(")");
}

function ExtendedAttributeNamedArgList() {
  Match(lex.Token.tId); Match("="); Match(lex.Token.tId); Match("("); ArgumentList(); Match(")");
}
