import * as idl from '@idlizer/core'
import { CJLayout, CommonLayoutBase, JavaLayout, system, TsLayout } from '@idlizer/libohos'
import * as path from 'path'

class OhosTsLayout extends TsLayout {}
class OhosArkTsLayout extends OhosTsLayout {
    protected override selectInterface(node: idl.IDLEntry): string | [string, string] {
        switch (node) {
            case system.typeCheckerARKTS: return ['#components', 'peers/type_check']
        }
        return super.selectInterface(node)
    }
}
class OhosJavaLayout extends JavaLayout {}
class OhosCJLayout extends CJLayout {}

export function ohosLayout(library: idl.PeerLibrary, prefix: string = '', packagePath: string = ''): idl.LayoutManagerStrategy {
    switch(library.language) {
        case idl.Language.TS: return new OhosTsLayout(library, prefix)
        case idl.Language.ARKTS: return new OhosArkTsLayout(library, prefix)
        case idl.Language.JAVA: return new OhosJavaLayout(library, prefix, packagePath)
        case idl.Language.CJ: return new OhosCJLayout(library, prefix)
    }
    throw new Error(`Unimplemented language "${library.language}"`)
}

///

class TsSpecialLayout extends CommonLayoutBase {
    constructor(
        library: idl.PeerLibrary,
        prefix: string,
        protected libName:string
    ) {
        super(library, prefix)
    }
    resolve(node: idl.IDLEntry, role: idl.LayoutNodeRole): string | [string, string] {
        const ns = idl.getNamespaceName(node)
        if (ns !== '') {
            return ns
        }
        return this.libName
    }
}
class ArkTsSpecialLayout extends TsSpecialLayout {
    resolve(node: idl.IDLEntry, role: idl.LayoutNodeRole): string | [string, string] {
        switch (node) {
            case system.typeCheckerARKTS: return ['#components', 'peers/type_check']
        }
        return super.resolve(node, role)
    }
}
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

export function alternativeLayout(library: idl.PeerLibrary, prefix: string = '', packagePath: string = '', libName: string = 'ohos'): idl.LayoutManagerStrategy {
    switch(library.language) {
        case idl.Language.TS: return new TsSpecialLayout(library, prefix, libName)
        case idl.Language.ARKTS: return new ArkTsSpecialLayout(library, prefix, libName)
        case idl.Language.JAVA: return new JavaSpecialLayout(library, prefix, packagePath, libName)
        case idl.Language.CJ: return new CJSpecialLayout(library, prefix, libName)
    }
    throw new Error(`Unimplemented language "${library.language}"`)
}

////////////////////////////////////////////////////////

export enum LayoutMode {
    NORMAL = 1,
    ARKTS12 = 2,
}

export function layout(library: idl.PeerLibrary, prefix: string = '', packagePath: string = '', mode = LayoutMode.NORMAL, libName: string = 'ohos'): idl.LayoutManagerStrategy {
    switch (mode) {
        case LayoutMode.NORMAL: {
            return ohosLayout(library, prefix, packagePath)
        }
        case LayoutMode.ARKTS12: {
            return alternativeLayout(library, prefix, packagePath, libName)
        }
    }
}
