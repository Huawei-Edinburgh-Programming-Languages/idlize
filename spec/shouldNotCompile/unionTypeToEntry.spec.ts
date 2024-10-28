
import * as idl from '../../src/idl'

function consumeAnyEntry(x:idl.IDLEntry) {}

// Can not pass Typedef as Type
consumeAnyEntry(idl.createUnionType([idl.IDLVoidType, idl.IDLI32Type]))

console.error("THIS TEST SHOULD NOT COMPILE!")
process.exitCode = -1
