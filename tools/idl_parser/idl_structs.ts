
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

export class Definitions {
  nodes: Node[] = [];

  accept(v: NodeVisitor) {}
}
