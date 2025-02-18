import * as idl from '@idlizer/core'
import { CommonLayoutBase, layout as commonLayout } from '@idlizer/libohos'
import * as path from 'path'

class TsSpecialLayout extends CommonLayoutBase {
    constructor(
        library: idl.PeerLibrary,
        prefix: string,
        protected libName:string
    ) {
        super(library, prefix)
    }
    resolve(node: idl.IDLEntry, role: idl.LayoutNodeRole): string {
        const ns = idl.getNamespaceName(node)
        if (ns !== '') {
            return ns
        }
        return this.libName
    }
}
class ArkTsSpecialLayout extends TsSpecialLayout {}
class JavaSpecialLayout extends CommonLayoutBase {
    constructor(library:idl.PeerLibrary, prefix:string, protected pkg:string, protected libName:string) {
        super(library, prefix)
    }
    resolve(node: idl.IDLEntry, role: idl.LayoutNodeRole): string {
        const ns = idl.getNamespaceName(node)
        if (ns !== '') {
            return path.join(this.pkg, ns)
        }
        return path.join(this.pkg, this.libName)
    }
}
class CJSpecialLayout extends TsSpecialLayout{}

////////////////////////////////////////////////////////

export enum LayoutMode {
    NORMAL = 1,
    ARKTS12 = 2,
}

export function layout(library: idl.PeerLibrary, prefix: string = '', packagePath: string = '', mode = LayoutMode.NORMAL, libName: string = 'ohos'): idl.LayoutManagerStrategy {
    switch (mode) {
        case LayoutMode.NORMAL: {
            return commonLayout(library, prefix, packagePath)
        }
        case LayoutMode.ARKTS12: {
            switch(library.language) {
                case idl.Language.TS: return new TsSpecialLayout(library, prefix, libName)
                case idl.Language.ARKTS: return new ArkTsSpecialLayout(library, prefix, libName)
                case idl.Language.JAVA: return new JavaSpecialLayout(library, prefix, packagePath, libName)
                case idl.Language.CJ: return new CJSpecialLayout(library, prefix, libName)
            }
            throw new Error(`Unimplemented language "${library.language}"`)
        }
    }
}
