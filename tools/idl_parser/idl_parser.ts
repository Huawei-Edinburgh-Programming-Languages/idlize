
import * as lex from "./idl_lexer";

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
/*
  let t: lex.Token;
  do {
    t = lex.getToken();
    console.log(t);    
  } while (t != lex.Token.tError && t != lex.Token.tEnd);
*/
}

test();
