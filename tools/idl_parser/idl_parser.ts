
import * as lex from "./idl_lexer";
/*
function Definitions() {
  while (1) {
    ExtendedAttributeList();
    Definition();
  } //Definitions
  //or empty
}

function test() {
  const s: string = "int i = 0; while (i < 10) print(i++);";

  lex.init(s);
  console.log(s);

  Definitions();

  let t: lex.Token;
  do {
    t = lex.getToken();
    console.log(t);    
  } while (t != lex.Token.tError && t != lex.Token.tEnd);
}

test();
*/

///////////////////////////////////////////////////////////////////////////////

let g_lookahead: lex.Token;

const g_char2token = new Map<string, Token>([
  ["=", Token.tEq],
  ["(", Token.tLBracket],
  [")", Token.tRBracket],
  ["{", Token.tLBrace],
  ["}", Token.tRBrace],
  ["<", Token.tLAngle],
  [">", Token.tRAngle],
  [":", Token.tColon],
  [";", Token.tSemicolon],
  [".", Token.tDot],
  [",", Token.tComma],
  ["+", Token.tPlus],
  ["-", Token.tMinus],
  ["*", Token.tAsterisk],
  ["...", Token.tEllipsis],
  ["?", Token.tQuestion],
//["", Token.t],
]);

function Match(t: lex.Token) {
  if (g_lookahead == t)
     g_lookahead = lex.getToken();
  else
    console.log("Error. Waiting for: " + t ", but got " + g_lookahead);
}

function Match(t: string) {
  if (g_char2token.has(t))
    Match(g_char2token.get(t));
  else
    console.log("Error. Unknown symbol: " + t);
}

function Parse() {
  const idl: string =
`package arkui.component.idlize;
import arkui.component.common;
callback Callback_Extender_OnProgress = void (f32 value);`

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
  CallbackOrInterfaceOrMixin();
  Namespace();
  Partial();
  Dictionary();
  Enum();
  Typedef();
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
  /*callback*/ CallbackRestOrInterface();
  /*interface*/ InterfaceOrMixin();
}

function InterfaceOrMixin() {
  InterfaceRest();
  MixinRest();
}

function InterfaceRest() {
  Match("identifier"); Inheritance(); Match("{"); InterfaceMembers(); Match("}"); Match(";");
}

function Partial() {
  /*partial*/ PartialDefinition();
}

function PartialDefinition() {
  /*interface*/ PartialInterfaceOrPartialMixin();
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
  Match("mixin"); Match("identifier"); Match("{"); MixinMembers(); Match("}") Match(";");
}

function MixinMembers() {
  ExtendedAttributeList(); MixinMember(); MixinMembers();
  // ε
}

function MixinMember() {
  Const();
  RegularOperation();
  Stringifier();
  /*OptionalReadOnly*/ AttributeRest();
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
  identifier
}

function OperationNameKeyword() {
  includes
}

function ArgumentList() {
  Argument(); Arguments();
  // ε
}

function Arguments() {
  , Argument(); Arguments
  // ε
}

function Argument() {
  ExtendedAttributeList(); ArgumentRest();
}

function ArgumentRest() {
  optional TypeWithExtendedAttributes(); ArgumentName(); Default();
  Match("Type"); Ellipsis(); ArgumentName();
}

function ArgumentName() {
  ArgumentNameKeyword();
  Match("identifier");
}

function Ellipsis() {
  //...
  // ε
}

function Constructor() {
  Match("constructor"); ( ArgumentList(); ) Match(";");
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
  = DefaultValue();
  // ε
}

function Enum() {
  enum identifier { EnumValueList(); } ;
}

function EnumValueList() {
  string EnumValueListComma();
}

function EnumValueListComma() {
  , EnumValueListString();
  // ε
}

function EnumValueListString() {
  string EnumValueListComma();
  // ε
}

function CallbackRest() {
  identifier = Type(); ( ArgumentList(); ) Match(";");
}

function Typedef() {
  typedef TypeWithExtendedAttributes(); identifier Match(";");
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
  any
  PromiseType();
}

function UnionType() {
  ( UnionMemberType(); or UnionMemberType(); UnionMemberTypes(); )
}

function UnionMemberType() {
  ExtendedAttributeList(); DistinguishableType();
  UnionType(); Null();
}

function UnionMemberTypes() {
  or UnionMemberType(); UnionMemberTypes();
  // ε
}

function DistinguishableType() {
  PrimitiveType(); Null();
  StringType(); Null();
  identifier Null();
  sequence < TypeWithExtendedAttributes(); > Null();
  async iterable < TypeWithExtendedAttributes(); > Null();
  object Null();
  symbol Null();
  BufferRelatedType(); Null();
  FrozenArray(); < TypeWithExtendedAttributes(); > Null();
  ObservableArray(); < TypeWithExtendedAttributes(); > Null();
  RecordType(); Null();
  undefined Null();
}

function PrimitiveType() {
  UnsignedIntegerType();
  UnrestrictedFloatType();
  boolean
  byte
  octet
  bigint
}

function UnrestrictedFloatType() {
  unrestricted FloatType();
  FloatType();
}

function FloatType() {
  float
  double
}

function UnsignedIntegerType() {
  unsigned IntegerType();
  IntegerType();
}

function IntegerType() {
  short
  long OptionalLong();
}

function OptionalLong() {
  long
  // ε
}

function StringType() {
  ByteString();
  DOMString();
  USVString();
}

function PromiseType() {
  Promise(); < Type(); >
}

function RecordType() {
  record < StringType(); , TypeWithExtendedAttributes(); >
}

function Null() {
  ?
  // ε
}

function BufferRelatedType() {
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
}

function ExtendedAttributeList() {
  [ ExtendedAttribute(); ExtendedAttributes(); ]
  // ε
}

function ExtendedAttributes() {
  , ExtendedAttribute(); ExtendedAttributes();
  // ε
}

function ExtendedAttribute() {
  ( ExtendedAttributeInner(); ) ExtendedAttributeRest();
  [ ExtendedAttributeInner(); ] ExtendedAttributeRest();
  { ExtendedAttributeInner(); } ExtendedAttributeRest();
  Other(); ExtendedAttributeRest();
}

function ExtendedAttributeRest() {
  ExtendedAttribute();
  // ε
}

function ExtendedAttributeInner() {
  ( ExtendedAttributeInner(); ) ExtendedAttributeInner();
  [ ExtendedAttributeInner(); ] ExtendedAttributeInner();
  { ExtendedAttributeInner(); } ExtendedAttributeInner();
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
  if (g_lookahead == ",") {
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
