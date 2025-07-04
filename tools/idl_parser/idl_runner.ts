
import * as par from "./idl_parser";
import * as idl from "./idl_structs";
import * as ir from "./idl_ir_printer";

let defs: idl.Definitions | null = par.Parse();

if (defs) {
  console.log("IDL has " + defs.nodes.length + " definitions");

  for (let i = 0; i < defs.nodes.length; i++) {
    console.log(i, defs.nodes[i].descr());
  }

  // call visitor
  let prn: ir.IRPrinter = new ir.IRPrinter();
  defs.accept(prn);
} else {
  console.log("defs is null");
}
