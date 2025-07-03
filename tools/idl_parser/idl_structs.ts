
export class Node {
  name(): string {
    return "Node";
  }
}

export class CallbackNode extends Node {
  name(): string {
    return "CallbackNode";
  }
}

export class Definitions {
  nodes: Node[] = [];
}
