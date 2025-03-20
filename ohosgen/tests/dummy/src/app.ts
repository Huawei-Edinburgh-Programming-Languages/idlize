
import { dtsDummy, idlDummy } from "#compat"
import { DTSDummyClass, DTSDummyChildClass } from "#compat"
// import { IDLDummyClass } from "#compat"

export function run() {

  console.log("Run dummy sample")

  dtsDummy()
  idlDummy()

  // new DTSDummyClass().dummy()
  new DTSDummyChildClass().dummy()
  // new IDLDummyClass().dummy()
}

