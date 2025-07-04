
import * as idl from "./idl_structs";

export class IRPrinter extends idl.NodeVisitor {
  visitCallback() {}
  visitInterface() {}
  visitNamespace() {}
  visitPartial() {}
  visitDictionary() {}
  visitEnum() {}
  visitTypedef() {}
  visitIncludesStatement() {}
  visitPackage() {}
}
