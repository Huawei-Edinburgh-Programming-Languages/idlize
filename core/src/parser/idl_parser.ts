
import * as lex from "./idl_lexer";
import * as idl from "./idl_structs";
import { Token } from "./idl_token";

let g_lookahead: lex.TokenData;

const g_char2token = new Map<string, Token>([
  ["=", Token.tEqual],
  ["(", Token.tLBracket],
  [")", Token.tRBracket],
  ["{", Token.tLBrace],
  ["}", Token.tRBrace],
  ["<", Token.tLAngle],
  [">", Token.tRAngle],
  ["[", Token.tLSqrBracket],
  ["]", Token.tRSqrBracket],
  [":", Token.tColon],
  [";", Token.tSemicolon],
  [".", Token.tDot],
  [",", Token.tComma],
  ["+", Token.tPlus],
  ["-", Token.tMinus],
  ["*", Token.tAsterisk],
  ["...", Token.tEllipsis],
  ["?", Token.tQuestion],
  ["any", Token.tAny],
  ["const", Token.tConst],
  ["Id", Token.tId],
  ["or", Token.tOr],
  ["package", Token.tPackage],
  ["callback", Token.tCallback],
  ["interface", Token.tInterface],
  ["void", Token.tVoid],
  ["constructor", Token.tConstructor],
  ["//comment", Token.tComment],
  ["/*comment*/", Token.tLongComment],
]);

function token2Name(t: Token): string {
  let res: string = "??";
  g_char2token.forEach((value, key) => {
    if (value === t) {
      res = key;
    }
  });

  return res;
}

function q(s: string) {
  return "\'" + s + "\'";
}

function Match(tArg: Token | string) {
  let tok: Token;
  let tok_name: string = "";
  if (typeof tArg === 'string') {
    if (g_char2token.has(tArg)) {
      tok_name = " (" + tArg + ")";
      tok = g_char2token.get(tArg) ! ;
    } else {
      console.log("Error. Unknown symbol: " + tArg);
      tok = Token.tError;
    }
  } else {
    tok = tArg;
  }

  if (g_lookahead.type == tok) {
     console.log("Match ok: " + tok + tok_name + " " + q(token2Name(tok)));
     g_lookahead = lex.getToken();
     console.log("new:  " + g_lookahead);
  } else {
    let msg: string = "Match Error. Waiting for: " +
                      tok + " " + q(token2Name(tok)) + ", but got " +
                      g_lookahead.type + " " + q(token2Name(g_lookahead.type));

    msg += " at pos: (" + lex.getCol() + ", " + lex.getRow() + ")\n";
    msg += lex.getLastLine() + "\n";
    msg += '-'.repeat(lex.getCol() - 1) + "^";  // -1 means that human start line from col == 1
                                                // and there is no spaces (' ') to the left of the first column
    throw new Error(msg);
  }
}

export function Parse(idl_text: string): idl.Definitions | null {
  console.log("Try to parse:");
  console.log(idl_text);

  lex.init(idl_text);

  let defs: idl.Definitions | null = null;

  g_lookahead = lex.getToken();
  if (g_lookahead.type != Token.tError && g_lookahead.type != Token.tEnd) {
    defs = Definitions(); // starting production
  }

  console.log("The end!");
  return defs;
}

// starting production
function Definitions(): idl.Definitions {
  let res: idl.Definitions = new idl.Definitions();
  do {
    if (g_lookahead.type == Token.tLSqrBracket)
      ExtendedAttributeList();

    Definition(res);
  } while (g_lookahead.type != Token.tEnd);
  //Definitions();
  // ε
  return res;
}

function Definition(node: idl.Definitions) {
  console.log("Definition >>>>");
  let chld: idl.Node | null = null;
  if (g_lookahead.type == Token.tCallback ||
      g_lookahead.type == Token.tInterface) {
    chld = CallbackOrInterfaceOrMixin();
  } else if (g_lookahead.type == Token.tNamespace) {
    chld = Namespace();
  } else if (g_lookahead.type == Token.tPartial) {
    chld = Partial();
  } else if (g_lookahead.type == Token.tDictionary) {
    chld = Dictionary();
  } else if (g_lookahead.type == Token.tTypedef) {
    chld = Typedef();
  } else if (g_lookahead.type == Token.tPackage) {
    chld = Package();
  } else {
    let txt = "Got unexpected token: " + g_lookahead.type + " " + q(token2Name(g_lookahead.type));
    console.log(txt);
    throw new Error(txt);
  }

  if (chld)
    node.nodes.push(chld);
}

function CallbackOrInterfaceOrMixin(): idl.Node | null {
  console.log("CallbackOrInterfaceOrMixin >>>>");
  if (g_lookahead.type == Token.tCallback) {
    Match(Token.tCallback);
    return CallbackRestOrInterface();
  } else if (g_lookahead.type == Token.tInterface) {
    Match(Token.tInterface);
    return InterfaceOrMixin();
  } else {
    return null;
  }
}

function InterfaceOrMixin(): idl.Node | null {
  console.log("InterfaceOrMixin >>>>");
  let res: idl.InterfaceNode = new idl.InterfaceNode(g_lookahead.text);
  if (g_lookahead.type == Token.tId) {
    //    identifier Inheritance { InterfaceMembers } ;
    Match(Token.tId); Inheritance(); Match(Token.tLBrace); InterfaceMembers(res); Match(Token.tRBrace); Match(Token.tSemicolon);
  }
  return res;
}

function Partial(): idl.Node | null {
  throw new Error("Partial node has not processed yet");
  Match(Token.tPartial); PartialDefinition();
}

function PartialDefinition() {
  Match(Token.tInterface); PartialInterfaceOrPartialMixin();
  PartialDictionary();
  Namespace();
}

function PartialInterfaceOrPartialMixin() {
  PartialInterfaceRest();
}

function PartialInterfaceRest() {
  let node: idl.InterfaceNode = new idl.InterfaceNode("FIX ME!!!");
  Match(Token.tId); Match(Token.tLBrace); PartialInterfaceMembers(node); Match(Token.tRBrace); Match(Token.tSemicolon);
}

//InterfaceMembers ::
//    ExtendedAttributeList InterfaceMember InterfaceMembers

function InterfaceMembers(node: idl.InterfaceNode) {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();

  let rpt: boolean;
  do {
    rpt = InterfaceMember(node);
  } while (rpt);
  // ε
}

const g_PartialFirstTokens: Token[] = [
  Token.tConst, Token.tLBracket, Token.tStatic,
  Token.tAsync, Token.tReadonly, Token.tAttribute
];

function InterfaceMember(node: idl.InterfaceNode): boolean {
  if (g_PartialFirstTokens.includes(g_lookahead.type) ||
      lex.IsItSingleType(g_lookahead.type)) {  // see Operation()
    PartialInterfaceMember(node);
    return true;
  } else if (g_lookahead.type == Token.tConstructor) {
    Constructor();
    return true;
  }
  return false;
}

function PartialInterfaceMembers(node: idl.InterfaceNode) {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();

  while (g_PartialFirstTokens.includes(g_lookahead.type) ||
      lex.IsItSingleType(g_lookahead.type)) {  // see Operation()
    PartialInterfaceMember(node);
  }
  // ε
}

function PartialInterfaceMember(node: idl.InterfaceNode) {
  Const();
  Operation(node);
  StaticMember();
  ReadOnlyMember();
  ReadWriteAttribute();
}

function Inheritance() {
  if (g_lookahead.type == Token.tColon) {
    Match(Token.tColon); Match(Token.tId);
  } else {
    // ε
  }
}

function Package(): idl.Node | null {
  let text: string = "";
  Match(Token.tPackage);
  while (g_lookahead.type != Token.tEnd) {
    text += g_lookahead.text;
    Match(Token.tId);
    if (g_lookahead.type == Token.tSemicolon)
      break;
    text += ".";
    Match(Token.tDot);
  }
  Match(Token.tSemicolon);
  let res: idl.PackageNode = new idl.PackageNode(text);
  return res;
}

function CallbackRestOrInterface(): idl.Node | null {
  console.log("CallbackRestOrInterface >>>>");
  if (g_lookahead.type == Token.tInterface) {
    Match(Token.tInterface);
    Match(Token.tId);
    Match(Token.tLBrace);
    const res = CallbackInterfaceMembers();
    Match(Token.tRBrace);
    Match(Token.tSemicolon);
    return res;
  } else {
    return CallbackRest();
  }
}

function CallbackInterfaceMembers(): idl.Node | null {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();
  CallbackInterfaceMember(); /*return*/ CallbackInterfaceMembers(); return null;
  // ε
}

function CallbackInterfaceMember() {
  Const();
  let dummy: idl.InterfaceNode = new idl.InterfaceNode("FIX ME!");
  RegularOperation(dummy);
}

function Const() {
  if (g_lookahead.type == Token.tConst) {
    Match(Token.tConst); ConstType(); Match(Token.tId); Match(Token.tEqual); ConstValue(); Match(Token.tSemicolon);
  }
}

function ConstValue() {
  BooleanLiteral();
  FloatLiteral();
  Match(Token.tInteger);  // terminal matched by the regular expressions
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
  Match(Token.tId);
}

function ReadOnlyMember() {
  if (g_lookahead.type == Token.tReadonly) {
    Match(Token.tReadonly); ReadOnlyMemberRest();
  }
}

function ReadOnlyMemberRest() {
  AttributeRest();
}

function ReadWriteAttribute() {
  AttributeRest();
}

function AttributeRest() {
  if (g_lookahead.type == Token.tAttribute) {
    Match(Token.tAttribute); TypeWithExtendedAttributes(); AttributeName(); Match(Token.tSemicolon);
  }
}

function AttributeName() {
  AttributeNameKeyword();
  Match(Token.tId);
}

function AttributeNameKeyword() {
  //async
}

function OptionalReadOnly() {
  Match(Token.tReadonly);
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

function Operation(node: idl.InterfaceNode) {
  if (lex.IsItSingleType(g_lookahead.type) || g_lookahead.type == Token.tLBracket) {
    RegularOperation(node);
  }
  //SpecialOperation(); // Not in use yet.
}

function RegularOperation(node: idl.InterfaceNode) {
  let res: idl.FuncNode;
  let rettype: idl.TypeNode | null = Type(); res = OperationRest();
  res.rettype = rettype;
  console.log("*** args: ", res);
  node.funcs.push(res);
}

function OperationRest(): idl.FuncNode {
  let res: idl.FuncNode;
  let name: string = "";
  name = OptionalOperationName(); Match(Token.tLBracket); res = ArgumentList(); Match(Token.tRBracket); Match(Token.tSemicolon);
  if (res)
    res.name = name;
  return res;
}

function OptionalOperationName(): string {
  if (g_lookahead.type == Token.tId) {
    return OperationName();
  } else {
    // ε
    return "";
  }
}

function OperationName(): string {
  //OperationNameKeyword();
  let res: string = g_lookahead.text;
  Match(Token.tId);
  return res;
}

function ArgumentList(): idl.FuncNode {
  console.log("ArgumentList >>>>");
  let res: idl.FuncNode = new idl.FuncNode();
  let arg = Argument();
  if (arg) {
    res.args.push(arg);
    Arguments(res);
  }
  // ε
  return res;
}

function Arguments(res: idl.FuncNode) {
  while (g_lookahead.type == Token.tComma) {
    Match(Token.tComma);
    let arg = Argument();
    if (arg) {
      res.args.push(arg);
    }
  }
  // ε
}

function Argument(): idl.ArgumentNode | null {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();
  return ArgumentRest();
}

function ArgumentRest(): idl.ArgumentNode | null {
  let res: idl.ArgumentNode | null = null ;
  if (g_lookahead.type == Token.tOptional) {
    Match(Token.tOptional); TypeWithExtendedAttributes(); res = ArgumentName(); Default();
  } else if (g_lookahead.type == Token.tId) {
    let type: string = g_lookahead.text;
    Match(Token.tId); Ellipsis(); res = ArgumentName();  // I replace Type to Id
    res.type = type;
    console.log("arg(1): ", res.name, res.type);
  } else if (lex.IsItSingleType(g_lookahead.type)) {  // functions can get args of standard type or user type
    let type: string = g_lookahead.text;              // SingleType is less power than "IsType"
    Match(g_lookahead.type); Ellipsis(); res = ArgumentName();
    res.type = type;
    console.log("arg(2): ", res.name, res.type);
  } else {  // no args
  }
  return res;
}

function ArgumentName(): idl.ArgumentNode {
  let res: idl.ArgumentNode = new idl.ArgumentNode;
  if (lex.IsItArgumentNameKeyword(g_lookahead.type)) {
    Match(g_lookahead.type);
  }
  res.name = g_lookahead.text;
  Match(Token.tId);
  return res;
}

function Ellipsis() {
  //...
  if (g_lookahead.type == Token.tEllipsis)
    Match(Token.tEllipsis);
  else {
  }
  // ε
}

function Constructor() {
  if (g_lookahead.type == Token.tConstructor) {
    Match(Token.tConstructor); Match(Token.tLBracket); ArgumentList(); Match(Token.tRBracket); Match(Token.tSemicolon);
  }
}

function StaticMember() {
  if (g_lookahead.type == Token.tStatic) {
    Match(Token.tStatic); StaticMemberRest();
  }
}

function StaticMemberRest() {
  OptionalReadOnly(); AttributeRest();
  let dummy: idl.InterfaceNode = new idl.InterfaceNode("FIX ME!");
  RegularOperation(dummy);
}

function OptionalType() {
  Match(Token.tComma); TypeWithExtendedAttributes();
  // ε
}

function OptionalArgumentList() {
  Match(Token.tLBracket); ArgumentList(); Match(Token.tRBracket);
  // ε
}

function Namespace(): idl.Node | null {
  let res: idl.NamespaceNode = new idl.NamespaceNode();
  Match(Token.tNamespace); Match(Token.tId); Match(Token.tLBrace); NamespaceMembers(); Match(Token.tRBrace); Match(Token.tSemicolon);
  return res;
}

function NamespaceMembers() {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();
  NamespaceMember(); NamespaceMembers();
  // ε
}

function NamespaceMember() {
  let dummy: idl.InterfaceNode = new idl.InterfaceNode("FIX ME!");
  RegularOperation(dummy);
  Match(Token.tReadonly); AttributeRest();
  Const();
}

function Dictionary(): idl.Node | null {
  let res: idl.DictionaryNode = new idl.DictionaryNode();
  Match(Token.tDictionary); Match(Token.tId); Inheritance(); Match(Token.tLBrace); DictionaryMembers(); Match(Token.tRBrace); Match(Token.tSemicolon);
  return res;
}

function DictionaryMembers() {
  DictionaryMember(); DictionaryMembers();
  // ε
}

function DictionaryMember() {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();
  DictionaryMemberRest();
}

function DictionaryMemberRest() {
  Type(); Match(Token.tId); Default(); Match(Token.tSemicolon);
}

function PartialDictionary() {
  Match(Token.tDictionary); Match(Token.tId); Match(Token.tLBrace); DictionaryMembers(); Match(Token.tRBrace); Match(Token.tSemicolon);
}

function Default() {
  if (g_lookahead.type == Token.tEqual) {
    Match(Token.tEqual); DefaultValue();
  } else {
    // ε
  }
}

function CallbackRest(): idl.Node | null {
  console.log("CallbackRestOrInterface >>>>");
  if (g_lookahead.type != Token.tId)
    return null;

  let res: idl.CallbackNode = new idl.CallbackNode(g_lookahead.text);
  Match(Token.tId);
  Match(Token.tEqual);
  res.rettype = Type();
  Match(Token.tLBracket);
  let fnode: idl.FuncNode = ArgumentList();
  res.args = fnode.args;
  Match(Token.tRBracket);
  Match(Token.tSemicolon);
  return res;
}

function Typedef(): idl.Node | null {
  let res: idl.TypedefNode = new idl.TypedefNode();
  Match(Token.tTypedef); TypeWithExtendedAttributes(); Match(Token.tId); Match(Token.tSemicolon);
  return res;
}

function Type(): idl.TypeNode | null {
  let res: idl.TypeNode | null = SingleType();
  if (!res) {
    UnionType(); Null();
  }
  return res;
}

function TypeWithExtendedAttributes() {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();
  Type();
}

function SingleType(): idl.TypeNode | null {
  if (lex.IsItDistinguishableType(g_lookahead.type)) {
    return DistinguishableType();
  } else if  (g_lookahead.type == Token.tAny) {
    let res: idl.TypeNode = new idl.TypeNode();
    res.type = idl.DataType.tAny;
    Match(Token.tAny);
    return res;
  } else if (g_lookahead.type == Token.tPromise) {
    PromiseType();
    return null;
  } else {
    return null;
  }
}

function UnionType() {
  if (g_lookahead.type == Token.tLBracket) {
    Match(Token.tLBracket); UnionMemberType(); Match(Token.tOr); UnionMemberType(); UnionMemberTypes(); Match(Token.tRBracket);
  }
}

function UnionMemberType() {
  if (g_lookahead.type == Token.tLSqrBracket)
    ExtendedAttributeList();
  DistinguishableType();
  UnionType(); Null();
}

function UnionMemberTypes() {
  Match(Token.tOr); UnionMemberType(); UnionMemberTypes();
  // ε
}

function DistinguishableType(): idl.TypeNode | null {
  let res: idl.TypeNode | null = null;
  if (lex.IsItPrimitiveType(g_lookahead.type)) {
    let prim_res: idl.PrimitiveTypeNode | null = PrimitiveType(); if (prim_res) prim_res.can_be_null = Null();
    res = prim_res;
  } else if (g_lookahead.type == Token.tString) {
    Match(Token.tString); Null();
  } else if (g_lookahead.type == Token.tId) {  // ! кажется, именно это условие должно пропускать произвольный пользовательский тип!
    let user_res: idl.UserTypeNode = new idl.UserTypeNode();
    user_res.type_name = g_lookahead.text;
    Match(Token.tId); Null();
    res = user_res;
  } else if (g_lookahead.type == Token.tSequence) {
    Match(Token.tSequence); Match(Token.tLAngle); TypeWithExtendedAttributes(); Match(Token.tRAngle); Null();
  } else if (g_lookahead.type == Token.tObject) {
    Match(Token.tObject); Null();
  } else if (g_lookahead.type == Token.tSymbol) {
    Match(Token.tSymbol); Null();
  } else if (g_lookahead.type == Token.tArrayBuffer) {
    BufferRelatedType(); Null();
  } else if (g_lookahead.type == Token.tFrozenArray) {
    Match(Token.tFrozenArray); Match(Token.tLAngle); TypeWithExtendedAttributes(); Match(Token.tRAngle); Null();
  } else if (g_lookahead.type == Token.tObservableArray) {
    Match(Token.tObservableArray); Match(Token.tLAngle); TypeWithExtendedAttributes(); Match(Token.tRAngle); Null();
  } else if (g_lookahead.type == Token.tRecord) {
    RecordType(); Null();
  } else if (g_lookahead.type == Token.tUndefined) {
    Match(Token.tUndefined); Null();
  }
  return res;
}

function PrimitiveType(): idl.PrimitiveTypeNode | null {
  let res: idl.PrimitiveTypeNode | null = null;
  res = UnsignedIntegerType();
  if (res)
    return res;
  res = UnrestrictedFloatType();
  if (res)
    return res;

  if (g_lookahead.type == Token.tBoolean) {
    Match(Token.tBoolean);
  } else if (g_lookahead.type == Token.tByte) {
    Match(Token.tByte);
  } else if (g_lookahead.type == Token.tOctet) {
    Match(Token.tOctet);
  } else if (g_lookahead.type == Token.tBigint) {
    Match(Token.tBigint);
  } else if (g_lookahead.type == Token.tVoid) {  // we have void type but webidl havn't
    res = new idl.PrimitiveTypeNode();
    Match(Token.tVoid);
    res.type = idl.DataType.tVoid;
  }

  return res;
}

function UnrestrictedFloatType(): idl.PrimitiveTypeNode | null {
  if (g_lookahead.type == Token.tUnrestricted) {
    Match(Token.tUnrestricted); return FloatType(true);
  } else {
    return FloatType(false);
  }
}

function FloatType(is_unrestricted: boolean): idl.PrimitiveTypeNode | null {
  if (g_lookahead.type == Token.tFloat) {
    let res: idl.PrimitiveTypeNode = new idl.PrimitiveTypeNode();
    res.type = idl.DataType.tFloat;  // is_unrestricted ? tUnrestrictedFloat : tFloat  ????
    Match(Token.tFloat);
    return res;
  } else if (g_lookahead.type == Token.tDouble) {
    let res: idl.PrimitiveTypeNode = new idl.PrimitiveTypeNode();
    res.type = idl.DataType.tDouble;
    Match(Token.tDouble);
    return res;
  }
  return null;
}

function UnsignedIntegerType(): idl.PrimitiveTypeNode | null {
  if (g_lookahead.type == Token.tUnsigned) {
    Match(Token.tUnsigned); return IntegerType(true);
  } else {
    return IntegerType(false);
  }
}

function IntegerType(is_unsigned: boolean): idl.PrimitiveTypeNode | null {
  if (g_lookahead.type == Token.tShort) {
    Match(Token.tShort);
    let res: idl.PrimitiveTypeNode = new idl.PrimitiveTypeNode();
    res.type = is_unsigned ? idl.DataType.tUnsignedShort : idl.DataType.tShort;
    return res;
  } else if (g_lookahead.type == Token.tLong) {
    Match(Token.tLong);
    let is_opt_long: boolean = OptionalLong();
    let res: idl.PrimitiveTypeNode = new idl.PrimitiveTypeNode();
    if (is_opt_long) {
      res.type = is_unsigned ? idl.DataType.tUnsignedLongLong : idl.DataType.tLongLong;
    } else {
      res.type = is_unsigned ? idl.DataType.tUnsignedLong : idl.DataType.tLong;
    }
    return res;
  } else {
    return null;
  }
}

function OptionalLong(): boolean {
  if (g_lookahead.type == Token.tLong) {
    Match(Token.tLong);
    return true;
  }
  return false;
  // | ε
}

function PromiseType() {
  if (g_lookahead.type == Token.tPromise) {
    Match(Token.tPromise); Match(Token.tLAngle); Type(); Match(Token.tRAngle);
  }
}

function RecordType() {
  Match(Token.tRecord); Match(Token.tLAngle); Match(Token.tString); Match(Token.tComma); TypeWithExtendedAttributes(); Match(Token.tRAngle);
}

function Null(): boolean {
  if (g_lookahead.type == Token.tQuestion) {
    Match(Token.tQuestion);
    return true;
  } else {
    // ε
    return false;
  }
}

function BufferRelatedType(): idl.TypeNode | null {
  if (g_lookahead.type == Token.tArrayBuffer) {
    let res: idl.TypeNode = new idl.TypeNode;
    res.type = idl.DataType.tArrayBuffer;
    return res;
  } else {
    return null;
  }
}

function ExtendedAttributeList() {
  if (g_lookahead.type == Token.tLSqrBracket) {
    Match(Token.tLSqrBracket); ExtendedAttribute();
    while (g_lookahead.type == Token.tComma) {
      Match(Token.tComma); ExtendedAttribute();
    }
    Match(Token.tRSqrBracket);
  } else {
    // ε
  }
}

function ExtendedAttribute() {
  Match(Token.tLBracket); ExtendedAttributeInner(); Match(Token.tRBracket); ExtendedAttributeRest();
  Match(Token.tLSqrBracket); ExtendedAttributeInner(); Match(Token.tRSqrBracket); ExtendedAttributeRest();
  Match(Token.tLBrace); ExtendedAttributeInner(); Match(Token.tRBrace); ExtendedAttributeRest();
  Other(); ExtendedAttributeRest();
}

function ExtendedAttributeRest() {
  ExtendedAttribute();
  // ε
}

function ExtendedAttributeInner() {
  Match(Token.tLBracket); ExtendedAttributeInner(); Match(Token.tRBracket); ExtendedAttributeInner();
  Match(Token.tLSqrBracket); ExtendedAttributeInner(); Match(Token.tRSqrBracket); ExtendedAttributeInner();
  Match(Token.tLBrace); ExtendedAttributeInner(); Match(Token.tRBrace); ExtendedAttributeInner();
  OtherOrComma(); ExtendedAttributeInner();
  // ε
}

function Other() {
  Token.tInteger,
  Token.tDecimal,
  Token.tId,
  Token.tString,
  /* "other" ??? */
  Token.tMinus,
  Token.tMinusInfinity,
  Token.tDot,
  Token.tEllipsis,
  Token.tColon,
  Token.tSemicolon,
  Token.tLAngle,
  Token.tEqual,
  Token.tRAngle,
  Token.tQuestion,
  Token.tAsterisk,
  Token.tFrozenArray,
  Token.tPlusInfinity,
  Token.tNaN,
  Token.tObservableArray,
  Token.tPromise,
  Token.tAny,
  Token.tBigint,
  Token.tBoolean,
  Token.tByte,
  Token.tDouble,
  Token.tFalse,
  Token.tFloat,
  Token.tLong,
  Token.tNull,
  Token.tObject,
  Token.tOctet,
  Token.tOr,
  Token.tOptional,
  Token.tRecord,
  Token.tSequence,
  Token.tShort,
  Token.tSymbol,
  Token.tTrue,
  Token.tUnsigned,
  Token.tUndefined,
  "ArgumentNameKeyword"  // non-terminal
  Token.tArrayBuffer
}

function OtherOrComma() {
  Other();
  Match(Token.tComma);
}

function IdentifierList() {
  Match(Token.tId);
  while (g_lookahead.type == Token.tComma) {
    Match(Token.tComma); Match(Token.tId);
  }
}

function ExtendedAttributeNoArgs() {
  Match(Token.tId);
}

function ExtendedAttributeArgList() {
  Match(Token.tId); Match(Token.tLBracket); ArgumentList(); Match(Token.tRBracket);
}

function ExtendedAttributeIdent() {
  Match(Token.tId); Match(Token.tEqual); Match(Token.tId);
}

function ExtendedAttributeWildcard() {
  Match(Token.tId); Match(Token.tEqual); Match(Token.tAsterisk);
}

function ExtendedAttributeIdentList() {
  Match(Token.tId); Match(Token.tEqual); Match(Token.tLBracket); IdentifierList(); Match(Token.tRBracket);
}

function ExtendedAttributeNamedArgList() {
  Match(Token.tId); Match(Token.tEqual); Match(Token.tId); Match(Token.tLBracket); ArgumentList(); Match(Token.tRBracket);
}
