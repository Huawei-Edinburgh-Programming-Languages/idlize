
import * as idl from '../../src/idl'

function consumeAnyType(x:idl.IDLType) {}

// Can not pass Interface as Type
consumeAnyType(idl.createInterface('test', idl.IDLKind.Interface))

console.error("THIS TEST SHOULD NOT COMPILE!")
process.exitCode = -1
