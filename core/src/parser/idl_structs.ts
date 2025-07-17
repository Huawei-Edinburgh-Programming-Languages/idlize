
import { Token } from "./idl_token";

export class NodeVisitor {
  visitCallback() {}
  visitInterface() {}
  visitNamespace() {}
  visitDictionary() {}
  visitTypedef() {}
  visitPackage() {}
}

export class Node {
  toString(): string {
    return "Node";
  }

  accept(v: NodeVisitor) {}
}

export class CallbackNode extends Node {
  args: ArgumentNode[] = [];
  rettype: TypeNode | null = null;
  name: string;

  constructor(val: string) {
    super();
    this.name = val;
  }

  toString(): string {
    return "CallbackNode: " + this.name;
  }

  accept(v: NodeVisitor) { v.visitCallback() }
}

export class DictionaryNode extends Node {
  name: string = "";
}

export class ArgumentNode extends Node {
  name: string = "";
  type: string = "";

  constructor() {
    super();
  }

  toString(): string {
    return this.name + ": " + this.type;
  }
}

export enum DataType {
  tUndefined = 0,
  tShort = 1,
  tLong = 2,
  tLongLong = 2,
  tUnsignedShort = 3,
  tUnsignedLong = 4,
  tUnsignedLongLong = 5,
  tVoid = 6,
  tAny = 7,
  tFloat = 8,
  tDouble = 9,

  tArrayBuffer = 80,
  tSharedArrayBuffer = 81,
  tDataView = 82,
  tInt8Array = 83,
  tInt16Array = 84,
  tInt32Array = 85,
  tUint8Array = 86,
  tUint16Array = 87,
  tUint32Array = 88,
  tUint8ClampedArray = 89,
  tBigInt64Array = 90,
  tBigUint64Array = 91,
  tFloat16Array = 92,
  tFloat32Array = 93,
  tFloat64Array = 94,

  tUser = 99,
};

export class TypeNode extends Node {
  type: DataType = DataType.tUndefined;

  /*constructor(t: DataType) {
    super();
    this.type = t;
  }*/
}

export class PrimitiveTypeNode extends TypeNode {
  can_be_null: boolean = false;

  toString(): string {
    return "PrimitiveTypeNode: ";
  }
}

export class UserTypeNode extends TypeNode {
  type_name: string = "";

  constructor() {
    super();
    this.type = DataType.tUser;
  }

  toString(): string {
    return "UserTypeNode: " + this.type_name;
  }
}

export class FuncNode extends Node {
  args: ArgumentNode[] = [];
  rettype: TypeNode | null = null;
  name: string = "";

  toString(): string {
    let res: string = this.rettype ? this.rettype.toString() : "";
    for (const a of this.args) {
      res += a;
    }

    return res;
  }
}

export class InterfaceNode extends Node {
  name: string = "";

  funcs: FuncNode[] = [];

  constructor(val: string) {
    super();
    this.name = val;
    //this.funcs = null;
  }

  toString(): string {
    let res: string = "InterfaceNode: " + this.name;
    if (this.funcs) {
      res += "\n";
      for (const f of this.funcs) {
        res += f;
        res += "\n";
      }
    }
    return res;
  }
}

export class AttributeNode extends Node {
  name: string = "";
  rettype: TypeNode | null = null;
}

export class NamespaceNode extends Node {
  name: string = "";
}

export class PackageNode extends Node {
  name: string = "";

  constructor(val: string) {
    super();
    this.name = val;
  }

  toString(): string {
    return "PackageNode: " + this.name;
  }
}

export class TypedefNode extends Node {
  name: string = "";
}

export class Definitions {
  // list of nodes: CallbackNode, InterfaceNode, ...
  nodes: Node[] = [];

  accept(v: NodeVisitor) {}
}
