
import * as lex from "./idl_lexer";
/*
function Definitions() {
  while (1) {
    ExtendedAttributeList();
    Definition();
  } //Definitions
  //or empty
}
*/

///////////////////////////////////////////////////////////////////////////////

let g_lookahead: lex.Token;

const g_char2token = new Map<string, lex.Token>([
  ["=", lex.Token.tEq],
  ["(", lex.Token.tLBracket],
  [")", lex.Token.tRBracket],
  ["{", lex.Token.tLBrace],
  ["}", lex.Token.tRBrace],
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
  if (typeof tArg === 'string') {
    if (g_char2token.has(tArg))
      tok = g_char2token.get(tArg) ! ;
    else {
      console.log("Error. Unknown symbol: " + tArg);
      tok = lex.Token.tError;
    }
  } else {
    tok = tArg;
  }

  if (g_lookahead == tok)
     g_lookahead = lex.getToken();
  else {
    throw new Error("Error. Waiting for: " + tok + ", but got " + g_lookahead);
  }
}

export function Parse() {
  const idl: string =
`package arkui.component.idlize;
import arkui.component.common;
callback Callback_Extender_OnProgress = void (f32 value);`

  console.log("Try to parse:");
  console.log(idl);

  lex.init(idl);

  g_lookahead = lex.getToken();
  while (g_lookahead != lex.Token.tError && g_lookahead != lex.Token.tEnd) {
    console.log(g_lookahead);    
    Definitions();
    g_lookahead = lex.getToken();
  }
}

// starting production
function Definitions() {
  ExtendedAttributeList();
  Definition();
  Definitions();
  // ε
}

function Definition() {
  if (g_lookahead == lex.Token.tCallback ||
      g_lookahead == lex.Token.tMixin)
    CallbackOrInterfaceOrMixin();

  if (g_lookahead == lex.Token.tNamespace)
    Namespace();

  if (g_lookahead == lex.Token.tPartial)
    Partial();

  if (g_lookahead == lex.Token.tDictionary)
    Dictionary();

  if (g_lookahead == lex.Token.tEnum)
    Enum();

  if (g_lookahead == lex.Token.tTypedef)
    Typedef();

  if (g_lookahead == lex.Token.tIncludes)
    IncludesStatement();
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
    Match("callback"); CallbackRestOrInterface();
  }
  if (g_lookahead == lex.Token.tMixin) {
    Match("interface"); InterfaceOrMixin();
  }
}

function InterfaceOrMixin() {
  InterfaceRest();
  MixinRest();
}

function InterfaceRest() {
  Match("identifier"); Inheritance(); Match("{"); InterfaceMembers(); Match("}"); Match(";");
}

function Partial() {
  Match("partial"); PartialDefinition();
}

function PartialDefinition() {
  Match("interface"); PartialInterfaceOrPartialMixin();
  PartialDictionary();
  Namespace();
}

function PartialInterfaceOrPartialMixin() {
  PartialInterfaceRest();
  MixinRest();
}

function PartialInterfaceRest() {
  Match("identifier"); Match("{"); PartialInterfaceMembers(); Match("}"); Match(";");
}

function InterfaceMembers() {
  ExtendedAttributeList(); InterfaceMember(); InterfaceMembers();
  // ε
}

function InterfaceMember() {
  PartialInterfaceMember();
  Constructor();
}

function PartialInterfaceMembers() {
  ExtendedAttributeList(); PartialInterfaceMember(); PartialInterfaceMembers();
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
  Match(":"); Match("identifier");
  // ε
}

function MixinRest() {
  Match("mixin"); Match("identifier"); Match("{"); MixinMembers(); Match("}"); Match(";");
}

function MixinMembers() {
  ExtendedAttributeList(); MixinMember(); MixinMembers();
  // ε
}

function MixinMember() {
  Const();
  RegularOperation();
  Stringifier();
  OptionalReadOnly(); AttributeRest();
}

function IncludesStatement() {
  Match("identifier"); Match("includes"); Match("identifier"); Match(";");
}

function CallbackRestOrInterface() {
  CallbackRest();
  Match("interface"); Match("identifier"); Match("{"); CallbackInterfaceMembers(); Match("}"); Match(";");
}

function CallbackInterfaceMembers() {
  ExtendedAttributeList(); CallbackInterfaceMember(); CallbackInterfaceMembers();
  // ε
}

function CallbackInterfaceMember() {
  Const();
  RegularOperation();
}

function Const() {
  Match("const"); ConstType(); Match("identifier"); Match("="); ConstValue(); Match(";");
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
  Match("identifier");
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
  Match("identifier");
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
  Match("identifier");
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
  ExtendedAttributeList(); ArgumentRest();
}

function ArgumentRest() {
  Match("optional"); TypeWithExtendedAttributes(); ArgumentName(); Default();
  Match("Type"); Ellipsis(); ArgumentName();
}

function ArgumentName() {
  ArgumentNameKeyword();
  Match("identifier");
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
  Match("namespace"); Match("identifier"); Match("{"); NamespaceMembers(); Match("}"); Match(";");
}

function NamespaceMembers() {
  ExtendedAttributeList(); NamespaceMember(); NamespaceMembers();
  // ε
}

function NamespaceMember() {
  RegularOperation();
  Match("readonly"); AttributeRest();
  Const();
}

function Dictionary() {
  Match("dictionary"); Match("identifier"); Inheritance(); Match("{"); DictionaryMembers(); Match("}"); Match(";");
}

function DictionaryMembers() {
  DictionaryMember(); DictionaryMembers();
  // ε
}

function DictionaryMember() {
  ExtendedAttributeList(); DictionaryMemberRest();
}

function DictionaryMemberRest() {
  Match("required"); TypeWithExtendedAttributes(); Match("identifier"); Match(";");
  Type(); Match("identifier"); Default(); Match(";");
}

function PartialDictionary() {
  Match("dictionary"); Match("identifier"); { DictionaryMembers(); } Match(";");
}

function Default() {
  Match("="); DefaultValue();
  // ε
}

function Enum() {
  Match("enum"); Match("identifier"); Match("{"); EnumValueList(); Match("}"); Match(";");
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
  Match("identifier"); Match("="); Type(); Match("("); ArgumentList(); Match(")"); Match(";");
}

function Typedef() {
  Match("typedef"); TypeWithExtendedAttributes(); Match("identifier"); Match(";");
}

function Type() {
  SingleType();
  UnionType(); Null();
}

function TypeWithExtendedAttributes() {
  ExtendedAttributeList(); Type();
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
  ExtendedAttributeList(); DistinguishableType();
  UnionType(); Null();
}

function UnionMemberTypes() {
  Match("or"); UnionMemberType(); UnionMemberTypes();
  // ε
}

function DistinguishableType() {
  PrimitiveType(); Null();
  StringType(); Null();
  Match("identifier"); Null();
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
  "identifier"
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
  Match("identifier"); Identifiers();
}

function Identifiers() {
  if (g_lookahead == lex.Token.tComma) {
    Match(","); Match("identifier"); Identifiers();
  } else {
    // ε
  }
}

function ExtendedAttributeNoArgs() {
  Match("identifier");
}

function ExtendedAttributeArgList() {
  Match("identifier"); Match("("); ArgumentList(); Match(")");
}

function ExtendedAttributeIdent() {
  Match("identifier"); Match("="); Match("identifier");
}

function ExtendedAttributeWildcard() {
  Match("identifier"); Match("="); Match("*");
}

function ExtendedAttributeIdentList() {
  Match("identifier"); Match("="); Match("("); IdentifierList(); Match(")");
}

function ExtendedAttributeNamedArgList() {
  Match("identifier"); Match("="); Match("identifier"); Match("("); ArgumentList(); Match(")");
}
