
import * as lex from "./idl_lexer";
/*
function Definitions() {
  while (1) {
    ExtendedAttributeList();
    Definition();
  } //Definitions
  //or empty
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

function CallbackOrInterfaceOrMixin() {}

function Namespace() {}
function Partial() {}
function Dictionary() {}
function Enum() {}
function Typedef() {}
function IncludesStatement() {}

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



function Definitions() {
  ExtendedAttributeList();
  Definition();
  Definitions();
//    ε
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
    async
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
    unrestricted
}

function CallbackOrInterfaceOrMixin() {
  callback CallbackRestOrInterface();
  interface InterfaceOrMixin();
}

function InterfaceOrMixin() {
  InterfaceRest();
  MixinRest();
}

function InterfaceRest() {
  identifier Inheritance(); { InterfaceMembers(); } ;
}

function Partial() {
  partial PartialDefinition();
}

function PartialDefinition() {
  interface PartialInterfaceOrPartialMixin();
  PartialDictionary();
  Namespace();
}

function PartialInterfaceOrPartialMixin() {
  PartialInterfaceRest();
  MixinRest();
}

function PartialInterfaceRest() {
  identifier { PartialInterfaceMembers(); } ;
}

function InterfaceMembers() {
  ExtendedAttributeList(); InterfaceMember(); InterfaceMembers();
  ε
}

function InterfaceMember() {
  PartialInterfaceMember();
  Constructor();
}

function PartialInterfaceMembers() {
  ExtendedAttributeList(); PartialInterfaceMember(); PartialInterfaceMembers();
  ε
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
  : identifier
  ε
}

function MixinRest() {
  mixin identifier { MixinMembers(); } ;
}

function MixinMembers() {
  ExtendedAttributeList(); MixinMember(); MixinMembers();
  ε
}

function MixinMember() {
  Const();
  RegularOperation();
  Stringifier();
  OptionalReadOnly AttributeRest();
}

function IncludesStatement() {
  identifier includes identifier ;
}

function CallbackRestOrInterface() {
  CallbackRest();
  interface identifier { CallbackInterfaceMembers(); } ;
}

function CallbackInterfaceMembers() {
  ExtendedAttributeList(); CallbackInterfaceMember(); CallbackInterfaceMembers();
  ε
}

function CallbackInterfaceMember() {
  Const();
  RegularOperation();
}

function Const() {
  const ConstType(); identifier = ConstValue(); ;
}

function ConstValue() {
  BooleanLiteral();
  FloatLiteral();
  integer
}

function BooleanLiteral() {
  true
  false
}

function FloatLiteral() {
  decimal
  -Infinity
  Infinity
  NaN
}

function ConstType() {
  PrimitiveType();
  identifier
}

function ReadOnlyMember() {
  readonly ReadOnlyMemberRest();
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
  inherit AttributeRest();
}

function AttributeRest() {
  attribute TypeWithExtendedAttributes(); AttributeName(); ;
}

function AttributeName() {
  AttributeNameKeyword();
  identifier
}

function AttributeNameKeyword() {
  async
  required
}

function OptionalReadOnly() {
  readonly
  ε
}

function DefaultValue() {
  ConstValue();
  string
  [ ]
  { }
  null
  undefined
}

function Operation() {
  RegularOperation();
  SpecialOperation();
}

function RegularOperation() {
  Type OperationRest();
}

function SpecialOperation() {
  Special(); RegularOperation();
}

function Special() {
  getter
  setter
  deleter
}

function OperationRest() {
  OptionalOperationName(); ( ArgumentList(); ) ;
}

function OptionalOperationName() {
  OperationName();
  ε
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
  ε
}

function Arguments() {
  , Argument(); Arguments
  ε
}

function Argument() {
  ExtendedAttributeList(); ArgumentRest();
}

function ArgumentRest() {
  optional TypeWithExtendedAttributes(); ArgumentName(); Default();
  Type Ellipsis(); ArgumentName();
}

function ArgumentName() {
  ArgumentNameKeyword();
  identifier
}

function Ellipsis() {
  ...
  ε
}

function Constructor() {
  constructor ( ArgumentList(); ) ;
}

function Stringifier() {
  stringifier StringifierRest();
}

function StringifierRest() {
  OptionalReadOnly(); AttributeRest();
  ;
}

function StaticMember() {
  static StaticMemberRest();
}

function StaticMemberRest() {
  OptionalReadOnly(); AttributeRest();
  RegularOperation();
}

function Iterable() {
  iterable < TypeWithExtendedAttributes(); OptionalType(); > ;
}

function OptionalType() {
  , TypeWithExtendedAttributes();
  ε
}

function AsyncIterable() {
  async iterable < TypeWithExtendedAttributes(); OptionalType(); > OptionalArgumentList(); ;
}

function OptionalArgumentList() {
  ( ArgumentList(); )
  ε
}

function ReadWriteMaplike() {
  MaplikeRest();
}

function MaplikeRest() {
  maplike < TypeWithExtendedAttributes(); , TypeWithExtendedAttributes(); > ;
}

function ReadWriteSetlike() {
  SetlikeRest();
}

function SetlikeRest() {
  setlike < TypeWithExtendedAttributes(); > ;
}

function Namespace() {
  namespace identifier { NamespaceMembers(); } ;
}

function NamespaceMembers() {
  ExtendedAttributeList(); NamespaceMember(); NamespaceMembers();
  ε
}

function NamespaceMember() {
  RegularOperation();
  readonly AttributeRest();
  Const();
}

function Dictionary() {
  dictionary identifier Inheritance(); { DictionaryMembers(); } ;
}

function DictionaryMembers() {
  DictionaryMember(); DictionaryMembers();
  ε
}

function DictionaryMember() {
  ExtendedAttributeList(); DictionaryMemberRest();
}

function DictionaryMemberRest() {
  required TypeWithExtendedAttributes(); identifier ;
  Type(); identifier Default(); ;
}

function PartialDictionary() {
  dictionary identifier { DictionaryMembers(); } ;
}

function Default() {
  = DefaultValue();
  ε
}

function Enum() {
  enum identifier { EnumValueList(); } ;
}

function EnumValueList() {
  string EnumValueListComma();
}

function EnumValueListComma() {
  , EnumValueListString();
  ε
}

function EnumValueListString() {
  string EnumValueListComma();
  ε
}

function CallbackRest() {
  identifier = Type(); ( ArgumentList(); ) ;
}

function Typedef() {
  typedef TypeWithExtendedAttributes(); identifier ;
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
  ε
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
  ε
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
  ε
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
  ε
}

function ExtendedAttributes() {
  , ExtendedAttribute(); ExtendedAttributes();
  ε
}

function ExtendedAttribute() {
  ( ExtendedAttributeInner(); ) ExtendedAttributeRest();
  [ ExtendedAttributeInner(); ] ExtendedAttributeRest();
  { ExtendedAttributeInner(); } ExtendedAttributeRest();
  Other(); ExtendedAttributeRest();
}

function ExtendedAttributeRest() {
  ExtendedAttribute();
  ε
}

function ExtendedAttributeInner() {
  ( ExtendedAttributeInner(); ) ExtendedAttributeInner();
  [ ExtendedAttributeInner(); ] ExtendedAttributeInner();
  { ExtendedAttributeInner(); } ExtendedAttributeInner();
  OtherOrComma(); ExtendedAttributeInner();
  ε
}

function Other() {
  integer
  decimal
  identifier
  string
  other
  -
  -Infinity
  .
  ...
  :
  ;
  <
  =
  >
  ?
  *
  ByteString
  DOMString
  FrozenArray
  Infinity
  NaN
  ObservableArray
  Promise
  USVString
  any
  bigint
  boolean
  byte
  double
  false
  float
  long
  null
  object
  octet
  or
  optional
  record
  sequence
  short
  symbol
  true
  unsigned
  undefined
  ArgumentNameKeyword
  BufferRelatedType
}

function OtherOrComma() {
  Other();
  ,
}

function IdentifierList() {
  identifier Identifiers();
}

function Identifiers() {
  , identifier Identifiers();
  ε
}

function ExtendedAttributeNoArgs() {
  identifier
}

function ExtendedAttributeArgList() {
  identifier ( ArgumentList(); )
}

function ExtendedAttributeIdent() {
  identifier = identifier
}

function ExtendedAttributeWildcard() {
  identifier = *
}

function ExtendedAttributeIdentList() {
  identifier = ( IdentifierList(); )
}

function ExtendedAttributeNamedArgList() {
  identifier = identifier ( ArgumentList(); )
}
