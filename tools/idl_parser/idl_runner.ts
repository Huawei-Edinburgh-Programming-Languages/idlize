
import * as par from "./idl_parser";
import * as idl from "./idl_structs";

let defs: idl.Definitions | null = par.Parse();

if (defs) {
  console.log("IDL has " + defs.nodes.length + " definitions");

  for (let i = 0; i < defs.nodes.length; i++) {
    console.log(i, defs.nodes[i].name());
  }
} else {
  console.log("defs is null");
}
