
import * as idl from '../../src/idl'

function consumeAnyEntry(x:idl.IDLEntry) {}

// Can not pass Type as Entry
consumeAnyEntry(idl.IDLVoidType)

console.error("THIS TEST SHOULD NOT COMPILE!")
process.exitCode = -1
