import * as idl from '@idlizer/core'

export const system = {
    typeCheckerTS: idl.createInterface('TypeChecker', idl.IDLInterfaceSubkind.Interface),
    typeCheckerARKTS: idl.createInterface('TypeChecker', idl.IDLInterfaceSubkind.Interface),
}
