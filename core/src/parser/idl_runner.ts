
import * as par from "./idl_parser";
import * as idl from "./idl_structs";
import * as ir from "./idl_ir_printer";


// Debug code for lexer
/*for (let i: number = 0; i < 40 && g_lookahead != lex.Token.tEnd; i++) {
  g_lookahead = lex.getToken().type;
  console.log("LookAhead[" + i + "]: " + g_lookahead + " == \'" + token2Name(g_lookahead) + "\' " + g_lookahead.text);
}
throw new Error("Done!");*/
// Debug code


const idl_text: string =
`callback Callback_Extender_OnProgress = void (float value);
callback Callback_OnButtonClick = bool (Point pos);
interface Call_Back_Iface {
    attribute Colors colors;
    Huks init();
    void invoke(T data);
};`

//const idl_text: string =
//`callback Callback_Extender_OnProgress = void (f32 value);`


//package arkui.component.idlize;
//callback Callback_Extender_OnProgress = void (f32 value);
//interface Content {/* test!! */};  // hahaha


/* test */
//import arkui.component.common;

let defs: idl.Definitions | null = par.Parse(idl_text);

if (defs) {
  console.log("IDL has " + defs.nodes.length + " definitions");

  for (let i = 0; i < defs.nodes.length; i++) {
    console.log(i, defs.nodes[i]);
  }

  // call visitor
  let prn: ir.IRPrinter = new ir.IRPrinter();
  defs.accept(prn);
} else {
  console.log("defs is null");
}
