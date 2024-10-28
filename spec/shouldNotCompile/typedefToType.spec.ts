
import * as idl from '../../src/idl'

function consumeAnyType(x:idl.IDLType) {}

// Can not pass Typedef as Type
consumeAnyType(idl.createTypedef('test', idl.IDLVoidType))

console.error("THIS TEST SHOULD NOT COMPILE!")
process.exitCode = -1
