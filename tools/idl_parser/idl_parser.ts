
import * as lex from "./idl_lexer";

function test() {
  const s: string = "int i = 0; while (i < 10) print(i++);";

  lex.init(s);
  console.log(s);

  let t: lex.Token;
  do {
    t = lex.getToken();
    console.log(t);    
  } while (t != lex.Token.tError && t != lex.Token.tEnd);
}

test();
