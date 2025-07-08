
export class NodeVisitor {
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

export class Node {
  descr(): string {
    return "Node";
  }

  accept(v: NodeVisitor) {}
}

export class CallbackNode extends Node {
  name: string;

  constructor(val: string) {
    super();
    this.name = val;
  }

  descr(): string {
    return "CallbackNode: " + this.name;
  }

  accept(v: NodeVisitor) { v.visitCallback() }
}

export class DictionaryNode extends Node {
  name: string = "";
}

export class IncludesNode extends Node {
  name: string = "";
}

export class InterfaceNode extends Node {
  name: string = "";
}

export class NamespaceNode extends Node {
  name: string = "";
}

export class PackageNode extends Node {
  name: string = "";
}

export class TypedefNode extends Node {
  name: string = "";
}

export class Definitions {
  // list of nodes: CallbackNode, InterfaceNode, ...
  nodes: Node[] = [];

  accept(v: NodeVisitor) {}
}
